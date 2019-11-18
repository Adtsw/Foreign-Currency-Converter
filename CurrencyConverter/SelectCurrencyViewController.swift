//
//  SelectCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by AASHISH on 13/11/19.
//  Copyright © 2019 Aashish. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController {

    let currencySource = ["US Dollar","CAD","GBP","Yuan","INR"]
    
    @IBOutlet weak var selectCurrencyLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var currencyAmount = ""
    var fromCurrency:Bool = false
    var toCurrency:Bool = false
    var fromCurrencyName:String = ""
    var toCurrencyName:String = ""
    var pickerValue:String = ""
    
    override func viewDidLoad() {
        print("View Did Load Called!")
        super.viewDidLoad()
        
        selectCurrencyLabel.text = " \(currencyAmount)"
        // Do any additional setup after loading the view.
    
        pickerView.dataSource = self
        pickerView.delegate = self
        
        print("from Currency : \(fromCurrency)")
        print("to Currency : \(toCurrency)")
        
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        performSegue(withIdentifier: "toHome", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pc = segue.destination as! ViewController
        
        if(fromCurrency == true){
            if(pickerValue == ""){
                pc.fromCurrencyName = "US Dollar"
                pc.toCurrencyName = toCurrencyName
            }else{
                pc.fromCurrencyName = pickerValue
                pc.toCurrencyName = toCurrencyName
            }
            
        }else{
            if(pickerValue == ""){
                pc.toCurrencyName = "US Dollar"
                pc.fromCurrencyName = fromCurrencyName
            }else{
                pc.toCurrencyName = pickerValue
                pc.fromCurrencyName = fromCurrencyName
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SelectCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencySource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select Called : \(currencySource[row])")
        pickerValue = currencySource[row]
        print("Picker Value = \(pickerValue)")
        selectCurrencyLabel.text = currencySource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencySource[row]
    }
}
