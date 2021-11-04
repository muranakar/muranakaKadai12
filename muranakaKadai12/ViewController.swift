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
    private var taxReletedValues: TaxRelatedValues?

    override func viewDidLoad() {
        super.viewDidLoad()
        consumptionTaxPercentDataRetrieve()
    }

    @IBAction private func calculationAndTaxDataStrageButton(_ sender: Any) {
        textFieldValidateAndTaxReletedValuesConfigue()
        guard taxReletedValues != nil else { return }
        priceIncludeingTaxLabelConfigue()
        consumptionTaxPercentDataStrage(
            num: taxReletedValues?.consumptionTaxRate
        )
    }

    private func textFieldValidateAndTaxReletedValuesConfigue() {
        guard let num1String = priceExcludingTaxTextField.text else { return }
        guard let num2String = consumptionTaxRateTextField.text else { return }
        guard let num1 = Int(num1String) else { showAlert(message: "税抜金額に、数値が入力されていません"); return }
        guard let num2 = Int(num2String) else { showAlert(message: "消費税率に、数値が入力されていません"); return }

        taxReletedValues = TaxRelatedValues(priceExcludingTax: num1, consumptionTaxRate: num2)
        return
    }

    private func priceIncludeingTaxLabelConfigue() {
        guard let num = taxReletedValues?.priceIncludingTax else { return }
        priceIncludingTaxLabel.text = String(num)
    }

    private func consumptionTaxPercentDataStrage(num: Int?) {
        guard let num = num else { return }
        userDefaults.set(num, forKey: "consumptionTaxRate")
    }

    private func consumptionTaxPercentDataRetrieve() {
        consumptionTaxRateTextField.text = "\(userDefaults.integer(forKey: "consumptionTaxRate"))"
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "課題11", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "修正", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
