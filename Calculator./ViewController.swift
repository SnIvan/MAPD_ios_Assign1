
//  Calculator.
//
//  Created by Ivan Sakhan on 2018-09-27.
//  Student ID 301006637
//
//  App description: Simple calculator app written on Swift4.
//
//  Calculator v 1.0
//
//  Copyright © 2018 CentennialCollege. All rights reserved.
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var operationLabel: UILabel!
    
    var currentNumber: String?
    var currentNumberSecondScreen: String?
    var previousSign: String = "+"
    var newScreen: Bool? = true
    var rememberButtonClicked: String = ""
    
    var result: Double = 0
    
    /* Actions for numbers
            mod -> get a remainder of the division
    */
    @IBAction func numberTap(_ sender: UIButton) {
        if rememberButtonClicked == "+" || rememberButtonClicked == "-" || rememberButtonClicked == "×" || rememberButtonClicked == "÷" || rememberButtonClicked == "mod" {
            newScreen = false
        }
        
        if newScreen! {
            self.clearScreen()
        }
        
        newScreen = false
        
        currentNumber = resultLabel.text
        if sender.currentTitle == "." {
            if resultLabel.text!.contains(".") {
                return
            }
            if currentNumber == "0" {
                resultLabel.text = currentNumber! + sender.currentTitle!
                return
            }
        }
        if currentNumber == "0" {
            currentNumber = ""
        }
        resultLabel.text = currentNumber! + sender.currentTitle!
        
        rememberButtonClicked = sender.currentTitle!
    }
    
    
    @IBAction func operatorTap(_ sender: UIButton) {
        
        if (rememberButtonClicked == "+" || rememberButtonClicked == "-" || rememberButtonClicked == "×" || rememberButtonClicked == "÷" || rememberButtonClicked == "mod") && sender.currentTitle != "=" {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            rememberButtonClicked = sender.currentTitle!
            previousSign = rememberButtonClicked
            return
        }
        
        if sender.currentTitle! == "=" {
            if operationLabel.text! == "" || rememberButtonClicked == "="{
                return
            }
        }
        
        currentNumberSecondScreen = operationLabel.text!
        
        if sender.currentTitle != "=" {
            if currentNumberSecondScreen == "" {
                currentNumberSecondScreen = resultLabel.text!
                operationLabel.text = currentNumberSecondScreen! + sender.currentTitle!
            } else {
                currentNumberSecondScreen = operationLabel.text!
                operationLabel.text = currentNumberSecondScreen! + resultLabel.text! + sender.currentTitle!
            }
        } else {
            if currentNumberSecondScreen == "" {
                currentNumberSecondScreen = resultLabel.text!
                operationLabel.text = currentNumberSecondScreen!
            } else {
                currentNumberSecondScreen = operationLabel.text!
                operationLabel.text = currentNumberSecondScreen! + resultLabel.text!
            }
        }
        
        switch previousSign {
        case "+":
            result += Double(resultLabel.text!)!
        case "-":
            result -= Double(resultLabel.text!)!
        case "×":
            result *= Double(resultLabel.text!)!
        case "÷":
            result /= Double(resultLabel.text!)!
        case "mod":
            result = result.truncatingRemainder(dividingBy: Double(resultLabel.text!)!)
        default:
            print("Error")
        }
        
        
        
        if sender.currentTitle! == "=" {
            operationLabel.text = "\(operationLabel.text!) "
            
            if formatNumber(result) == "inf" || formatNumber(result) == "NaN" {
                resultLabel.text = "Error"
            } else {
                resultLabel.text = formatNumber(result)
            }
            self.resetCalculator()
        } else {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousSign = sender.currentTitle!
            
            resultLabel.text = "0"
        }
        
        
        rememberButtonClicked = sender.currentTitle!
        
        
    }
    
    //Action for C button and for +/- button
    @IBAction func otherButtonTap(_ sender: UIButton) {
        if sender.currentTitle == "C" {
            self.clearScreen()
        } else if sender.currentTitle == "+/-" {
            var tempNum = Double(resultLabel.text!)!
            tempNum = -tempNum
            resultLabel.text = self.formatNumber(tempNum)
        }
        
        rememberButtonClicked = sender.currentTitle!
    }
    
    //Reset resultLabel and operationLabel
    func clearScreen() -> Void {
        operationLabel.text = ""
        resultLabel.text = "0"
        result = 0
        previousSign = "+"
        newScreen = true
    }
    
    func resetCalculator() -> Void {
        previousSign = "+"
        newScreen = true
        result = 0
    }
    
    func formatNumber(_ number: Double) -> String{
        return String(format: "%g", number)
    }
}

