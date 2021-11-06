//
//  ViewController.swift
//  muranakaKadai12
//
//  Created by 村中令 on 2021/11/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var priceExcludingTaxTextField: UITextField!
    @IBOutlet weak private var consumptionTaxRateTextField: UITextField!
    @IBOutlet weak private var priceIncludingTaxLabel: UILabel!
    private let userDefaults = UserDefaults.standard

    private let consumptionTaxRateKey = "consumptionTaxRate"

    enum ValidationResult {
        case invalidExcludingTax
        case invalidTaxRate
        case valid(TaxRelatedValues)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndDisplayConsumptionTaxRate()
    }

    @IBAction private func calculationAndTaxDataStrageButton(_ sender: Any) {
        switch validateTextFields() {
        case .invalidExcludingTax:
            showAlert(message: "税抜金額に、数値が入力されていません")
        case .invalidTaxRate:
            showAlert(message: "消費税率に、数値が入力されていません")
        case .valid(let values):
            configurePriceIncludeingTaxLabel(priceIncludingTax: values.priceIncludingTax)
            saveConsumptionTaxPercentData(
                consumptionTaxRate: values.consumptionTaxRate
            )
        }
    }

    private func validateTextFields() -> ValidationResult {
        guard let num1 = Int(priceExcludingTaxTextField.text ?? "") else {
            return .invalidExcludingTax
        }
        guard let num2 = Int(consumptionTaxRateTextField.text ?? "") else {
            return .invalidTaxRate
        }

        let taxReletedValues = TaxRelatedValues(priceExcludingTax: num1, consumptionTaxRate: num2)
        return .valid(taxReletedValues)
    }

    private func configurePriceIncludeingTaxLabel(priceIncludingTax: Int) {
        priceIncludingTaxLabel.text = String(priceIncludingTax)
    }

    private func saveConsumptionTaxPercentData(consumptionTaxRate: Int) {
        userDefaults.set(consumptionTaxRate, forKey: consumptionTaxRateKey)
    }

    private func loadAndDisplayConsumptionTaxRate() {
        consumptionTaxRateTextField.text = "\(userDefaults.integer(forKey: consumptionTaxRateKey))"
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "課題11", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "修正", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
