//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by RTC01 on 2017/10/3.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var result: Double? {
        return accumulator
    }
}
private var accumulator: Double?
