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
            
        }
    }
    
    @IBAction func floatingPoint(_ sender: UIButton) {
        
    }
    
    @IBAction func backSpace(_ sender: UIButton) {
        
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

