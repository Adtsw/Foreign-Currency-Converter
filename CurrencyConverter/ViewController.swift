

import UIKit

class ViewController: UIViewController {

    var currencyValue:Double = 0.0
    var whichCurrency:Int = 0;                              // to check which 'change' button is called - from or to
    var result:Double = 0.0
    var fromCurrencyName:String = "CAD"
    var toCurrencyName:String = "US Dollar"
    var exchangeSet:String = ""
    var exchangeRateDictionary: [String: String] = ["US Dollar:US Dollar": "1.00","US Dollar:CAD": "1.32","US Dollar:GBP": "0.77","US Dollar:Yuan": "7.01","US Dollar:INR": "71.70", "CAD:CAD": "1.00", "CAD:US Dollar": "0.76", "CAD:GBP": "0.59", "CAD:Yuan": "5.29", "CAD:INR": "54.22", "GBP:GBP": "1.00", "GBP:US Dollar": "1.29", "GBP:CAD": "1.71", "GBP:Yuan": "9.05", "GBP:INR": "92.54", "Yuan:Yuan": "1.00", "Yuan:US Dollar": "0.14", "Yuan:CAD": "0.19", "Yuan:GBP": "0.11", "Yuan:INR": "10.23", "INR:INR": "1.00", "INR:US Dollar": "0.014", "INR:CAD": "0.018", "INR:GBP": "0.011", "INR:Yuan": "0.098"]
    var flagDictionary: [String:String] = ["US Dollar": "usa", "CAD": "canada","GBP": "bretain","Yuan": "china", "INR": "India"]
    
    
    @IBOutlet weak var currencyAmount: UITextField!
    
    @IBOutlet weak var fromLabelValue: UILabel!
    
    @IBOutlet weak var toLabelValue: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var rateField: UITextField!
    
    @IBOutlet weak var fromImage: UIImageView!
    
    @IBOutlet weak var toImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Setting 'From' and 'To' Label Values
        fromLabelValue.text = fromCurrencyName
        toLabelValue.text = toCurrencyName
        
        exchangeSet = fromCurrencyName+":"+toCurrencyName
        print("Exchange set Value : \(exchangeSet)")
        
        refreshRate(exchangeSetValue: exchangeSet)
        refreshImage(exchangeSetValue: exchangeSet)
        
    }
    
    func refreshImage (exchangeSetValue: String){
        let flagArray = exchangeSetValue.components(separatedBy: ":")
        print(flagArray[0])
        print(flagArray[1])
        print(flagDictionary[flagArray[0]]!)
        print(flagDictionary[flagArray[1]]!)
        fromImage.image = UIImage(named: flagDictionary[flagArray[0]]!)
        toImage.image = UIImage(named: flagDictionary[flagArray[1]]!)
        print("Refresh Executed")
    }
    
    func refreshRate(exchangeSetValue: String){
        print("Referesh Called : Exchange Set Value : \(exchangeSetValue)")
        print(exchangeRateDictionary[exchangeSetValue]!)
        
        //rateLabel.text = exchangeRateDictionary[exchangeSetValue]!
        
        rateField.text = exchangeRateDictionary[exchangeSetValue]!
    }
    

    @IBAction func ConvertRate(_ sender: Any) {
        self.currencyValue = Double(currencyAmount.text!) ?? 1.0
        result = currencyValue * Double(exchangeRateDictionary[exchangeSet]!)!
        print("Currency Rate : \(result)")
    }
    
    @IBAction func changeCurrency(_ sender: UIButton) {
        
        whichCurrency = sender.tag
        
        performSegue(withIdentifier: "toSelectCurrency", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectCurrencyViewController
        
        if(whichCurrency == 1){
            //vc.fromCurrency = self.currencyValue
            vc.fromCurrency = true
            vc.toCurrency = false
            vc.toCurrencyName = self.toCurrencyName
        }else{
            vc.fromCurrency = false
            vc.toCurrency = true
            vc.fromCurrencyName = self.fromCurrencyName
        }
        
    }
    

    @IBAction func showResult(_ sender: Any) {
        let roundedResult = String(format: "%.2f", result)
        let resultInfo = UIAlertController(title: "Conversion Result", message: "Converted amount is : \(roundedResult)", preferredStyle: .alert)
        resultInfo.addAction(UIAlertAction(title: "Ok",style: .default))
        
        self.present(resultInfo, animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateCurrencyRate(_ sender: Any) {
        print("Before : \(exchangeRateDictionary[exchangeSet])")
        exchangeRateDictionary[exchangeSet] = rateField.text ?? "0.0"
        print("Change Completed")
        print("After : \(exchangeRateDictionary[exchangeSet])")
    }
    
}

