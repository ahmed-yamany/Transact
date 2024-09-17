//
//  Stepper.swift
//
//
//  Created by Ahmed Yamany on 23/05/2024.
//

import SwiftUI

public struct Stepper: View {
    @Binding public var value: Int
    public var minValue: Int = -1000
    public var maxValue: Int = 1000
    
    public init(value: Binding<Int>, minValue: Int, maxValue: Int) {
        self._value = value
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    @Environment(\.stepperStyle) private var style: any StepperStyle
    
    public var body: some View {
        AnyView(style.makeBody(configurations: configurations))
    }
    
    private var configurations: StepperConfigurations {
        StepperConfigurations(
            value: value,
            minValue: minValue,
            maxValue: maxValue,
            onPlus: {
                if value < maxValue { value += 1 }
            }, onMinus: {
                if value > minValue { value -= 1 }
            }
        )
    }
}
