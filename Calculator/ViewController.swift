//
//  ViewController.swift
//  Calculator
//
//  Created by RTC01 on 2017/10/3.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var decimalSeparator: UIButton!
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = numberFormatter.string(from: newValue as NSNumber)
        }
    }
    var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    private var numberFormatter = NumberFormatter()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymble = sender.currentTitle {
            brain.performOperation(mathematicalSymble)
        }
        if let result = brain.result {
            displayValue = result
        }
        let postFixDescription = brain.resultIsPending ? "..." : "="
        history.text = brain.description + postFixDescription
    }
    
    @IBAction func floatingPoint(_ sender: UIButton) {
        if !userIsInthemiddleOfTyping {
            display.text = "0" + numberFormatter.decimalSeparator
        } else if !display.text!.contains(numberFormatter.decimalseparator) {
            display.text = display.text! + numberFormatter.decimalSeparator
        }
         userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func backSpace(_ sender: UIButton) {
        guard userIsInTheMiddleOfTyping else { return }
        display.text = String(display.text!.characters.dropLast())
        if display.text?.characters.count == 0 {
            displayValue = 0.0
            userIsInTheMiddleOfTyping = false
        }
    }
    
    @IBAction private func clearAll(_ sender: UIButton) {
        brain.clear()
        displayValue = 0.0
        history.text = " "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberFormatter.maximumFractionDigits = 6
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.minimumIntegerDigits = 1
        decimalSeparator.setTitle(numberFormatter.decimalSeparator, for: .normal)
        brain.numberFormatter = numberFormatter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

