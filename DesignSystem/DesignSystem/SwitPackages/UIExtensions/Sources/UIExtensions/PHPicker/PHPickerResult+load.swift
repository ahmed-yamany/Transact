//  Created by Ahmed Yamany on 11/06/2024.
//

import Foundation
import PhotosUI

private extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

public extension [PHPickerResult] {
    func load<T: NSItemProviderReading>() async throws -> [T?] {
        try await asyncMap { try await $0.load()}
    }
}

public extension PHPickerResult {
    func load<T: NSItemProviderReading>() async throws -> T? {
        try await withCheckedThrowingContinuation { continuation in
            itemProvider.loadObject(ofClass: T.self) { object, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let object = object as? T {
                    continuation.resume(returning: object)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
