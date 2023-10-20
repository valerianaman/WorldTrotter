//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Gonzalo Benítez Bueno on 19/10/23.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)}
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
   
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
       
        var myValue = NumberFormatter()
        if let text = textField.text{
            let valueDouble = myValue.number(from: text)?.doubleValue ?? 0
            fahrenheitValue = Measurement(value: valueDouble, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value:celsiusValue.value))
        } else {
            celsiusLabel.text="???"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentLocale = NSLocale.current
        let decimalSeparator = currentLocale.decimalSeparator!
        let existingTextHasDecimalSeparator = textField.text?.range(of:decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        let replacementTextHasLetters = string.rangeOfCharacter(from: NSCharacterSet.letters)
        let replacementTextHasPunctuations = string.rangeOfCharacter(from: NSCharacterSet.punctuationCharacters)
        let replacementTextHasSymbols = string.rangeOfCharacter(from: NSCharacterSet.symbols)
        
        
        if replacementTextHasLetters != nil 
//            || replacementTextHasPunctuations != nil
            || replacementTextHasSymbols != nil {
            return false
        } else {
            if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        }
        
    }
    
}

