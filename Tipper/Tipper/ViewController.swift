import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipSplitTextField: UITextField!
    @IBOutlet weak var totalSplitTextField: UITextField!
    
    var totalBill: Double? {
        return Double(totalBillTextField.text!)
    }
    
    var tipPercentage: Double = 0.15
    var numberOfPeople: Double = 1.0
    private var formatter: NumberFormatter!
    
    
    
    override func viewDidLoad() { // executes whenever our app loads
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        totalBillTextField.delegate = self
        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimum = 0
    }

    @IBAction func tipSliderChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        tipPercentLabel.text = "\(sliderValue)%"
        tipPercentage = Double(Int(sender.value)) * 0.01
        updateInterface()
    }
    
    @IBAction func splitStepperChanged(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        splitLabel.text = "\(stepperValue)"
        numberOfPeople = Double(stepperValue)
        updateInterface()
    }
    
    @IBAction func totalBillTextFieldChanged(_ sender: UITextField) {
        updateInterface()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        totalBillTextField.resignFirstResponder()
    }
    
    func updateInterface(){
        if let totalBill = self.totalBill {
            tipTextField.text = String(format: "$%.2f", (totalBill * tipPercentage))
            totalTextField.text = String(format: "$%.2f", (totalBill * tipPercentage) + totalBill)
            tipSplitTextField.text = String(format: "$%.2f", (totalBill * tipPercentage) / numberOfPeople)
            totalSplitTextField.text = String(format: "$%.2f", ((totalBill * tipPercentage) + totalBill) / numberOfPeople)
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return formatter.number(from: "\(textField.text ?? "0.00")\(string)") != nil
    }
}

