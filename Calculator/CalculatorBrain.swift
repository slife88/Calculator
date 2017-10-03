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
    
    var resultIsPending: Bool {
        return pendingBinaryOperation != nil
    }
    
    mutating func setOperand(_ operand: Double){
        if !resultIsPending { clear() }
        accumulator = operand
        descriptions.append(formattedAccumulator!)
    }
    
    mutating func performOperation(_ symble: String) {
        guard let operation = operations[symble] else { return }
        switch operation {
        case .constant(let value):
            accumulator = value
            descriptions.append(symble)
        case .operationNoArgument(let f):
            accumulator = f()
            descriptions.append(symble)
        case .unaryOperation(let f):
            if let operand = accumulator {
                if resultIsPending {
                    let lastOperand = descriptions.last!
                    descriptions = [String](descriptions.dropLast()) + [symble + "(" + lastOperand + ")"]
                } else {
                    descriptions = [symble + "("] + descriptions + [")"]
                }
                accumulator = f(operand)
            }
        case .binaryoperation(let f):
            if resultIsPending {
                performBinayOperation()
            }
            if accumulator != nil {
                pendingBinaryOperation = pendingBinaryOperation(function: f, firstOperand: accumulator!)
            }
            descriptions.append(symble)
        case .equals:
            performBinaryOperation()
        }
    }
    
    mutating func clear {
        accumulator = nil
        pendingBinaryOperation = nil
        descriptions = []
    }
    
    weak var numberFormatter: NumberFormatter?

    var description: String {
        var returnString: String = ""
        for element in descriptions {
            returnString += element
        }
        return returnString
    }
    private var descriptions: [String] = []
    
    private var accumulator: Double?
    
    private var formattedAccumulator: String? {
        if let number = accumulator {
            return numberFormatter?.string(from: number as<#T##NSNumber#>) ?? String(number)
        } else {
            return nil
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case operationNoArguments(() -> Double)
        case equals
    }
    
    private var operations: Dictionary<String : Operation> = [
        "∏": Operation.constant(Double.pi),
        "E": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "%": Operation.unaryOperation({ $0/100 }),
        "±": Operation.unaryOperation { -$0 },
        "Sin": Operation.unaryOperation(sin),
        "Cos": Operation.unaryOperation(cos),
        "Tan": Operation.unaryOperation(tan),
        "Ran": Operation.operationNoArguments({ Double(drand48()) }),
        "+": Operation.binaryOperation(+),
        "−": Operation.binaryOperation(-),
        "×": Operation.binaryOperation(*),
        "÷": Operation.binaryOperation(/),
        "=": Operation.equals
    ]
    
    private mutating func performBinayOperation {
        guard pendingBinaryOperation != nil && accumulator != nil else { return }
        accumulator = pendingBinaryOperation!.perForm(with: accumulator!)
        pendingBinaryOperation= nil
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perForm(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
}
