//
//  OTPViewModel.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol OTPViewModelInterface: ObservableObject {
    var phonenumber: String { get set }
    var otp: String { get set }
    var otpLength: Int { get set }
    var otpCodeExpiresIn: String { get set }
    var disableVerifyButton: Bool { get set }
    var disableResendButton: Bool { get set }

    func resendButtonTapped()
    func verifyButtonTapped()
}

@MainActor
public final class OTPViewModel: OTPViewModelInterface {
    @Published public var phonenumber: String
    @Published public var otpLength: Int
    @Published public var otpCodeExpiresIn: String = ""
    @Published public var otp: String = ""
    @Published public var disableVerifyButton: Bool = true
    @Published public var disableResendButton: Bool = true

    private let coordinator: OTPCoordinatorInterface
    private let useCase: OTPUseCaseInterface
    private var otpCodeExpiresSeconds: Int

    private var expirationTimer: Timer?
    private var otpCancellable: Cancellable?

    private var validateOtpTask: Task<Void, Never>?
    private var verifyOtpTask: Task<Void, Never>?

    public init(_ entity: OTPViewModelEntity, coordinator: OTPCoordinatorInterface, useCase: OTPUseCaseInterface) {
        self.coordinator = coordinator
        self.useCase = useCase

        phonenumber = entity.phoneNumber
        otpLength = entity.otpLength
        otpCodeExpiresSeconds = entity.otpCodeExpiresSeconds

        scheduleOTPExpirationTimer()
        bindOTPValidation()
    }

    deinit {
        expirationTimer?.invalidate()
    }

    public func resendButtonTapped() {
        Task {
            disableResendButton = true
            do {
                try await useCase.resendOTP(for: phonenumber)
            } catch {
                disableResendButton = false
            }
        }
    }

    public func verifyButtonTapped() {
        verifyOtpTask?.cancel()
        verifyOtpTask = Task {
            disableResendButton = true
            do {
                try await useCase.verifyOTP(otp)
                coordinator.navigateToUpdatePassword()
            } catch {
                disableResendButton = false
            }
        }
    }

    private func scheduleOTPExpirationTimer() {
        expirationTimer?.invalidate()
        expirationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            Task {
                await MainActor.run { [weak self] in
                    self?.updateOTPExpirationTime()
                }
            }
        }
    }

    private func updateOTPExpirationTime() {
        otpCodeExpiresSeconds -= 1
        otpCodeExpiresIn = secondsToMinutesString(seconds: otpCodeExpiresSeconds)
        if otpCodeExpiresSeconds <= 0 {
            disableResendButton = false
            expirationTimer?.invalidate()
        }
    }

    func secondsToMinutesString(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }

    private func bindOTPValidation() {
        otpCancellable?.cancel()
        otpCancellable = $otp.sink { [weak self] otp in
            guard let self else { return }
            validateOtpTask?.cancel()
            validateOtpTask = validateOTP(otp)
        }
    }

    private func validateOTP(_ otp: String) -> Task<Void, Never> {
        Task {
            do {
                try await useCase.validateOTP(otp, length: otpLength)
                disableVerifyButton = false
            } catch {
                disableVerifyButton = true
            }
        }
    }
}
