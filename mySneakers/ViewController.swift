//
//  ViewController.swift
//  mySneakers
//
//  Created by kenter on 18/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var typeSegmented: UISegmentedControl!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var sizeStepper: UIStepper!
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var resultIV: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var colors: [String] = ["Blanc", "Noir", "Rouge", "Bleu", "Vert"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        updateGenderLabel()
        updateSizeLabel()
        setupPicker()
        getImage()
    }
    
    func getImage() {
        let imageString = getGender() + "_" + getType() + "_" + getColor()
        resultIV.image = UIImage(named: imageString)
        updateResultLabel()
    }
    
    func getType() -> String {
        switch typeSegmented.selectedSegmentIndex {
        case 0: return "city"
        case 1: return "running"
        default: return "basket"
        }
    }
    
    func getGender() -> String {
        return genderSwitch.isOn ? "boy" : "girl"
    }
    
    func getColor() -> String {
        let index = colorPicker.selectedRow(inComponent: 0)
        switch index {
        case 0: return "white"
        case 1: return "black"
        case 2: return "red"
        case 3: return "blue"
        default: return "green"
        }
    }
    
    func updateResultLabel() {
        var str = ""
        if let name = nameTF.text, name != "" {
            str += "Salut " + name + ". "
        }
        str += "J'ai trouvé pour vous une chaussure dans la pointure " + String(Int(sizeStepper.value))
        resultLabel.text = str
    }
    
    func updateGenderLabel() {
        let str = genderSwitch.isOn ? "Homme" : "Femme"
        genderLabel.text = str
    }
    
    func updateSizeLabel() {
        let sizeString = "Pointure: \(Int(sizeStepper.value))"
        sizeLabel.text = sizeString
    }
   
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        getImage()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        updateGenderLabel()
        getImage()
    }
    
    @IBAction func stepperChanger(_ sender: UIStepper) {
        updateSizeLabel()
        getImage()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func setupTextField() {
        nameTF.delegate = self
    }
    
    // Quand on va appuyer sur le done, notre clavier va se refermer
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPicker() {
        colorPicker.delegate = self
        colorPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getImage()
    }
}
