//
//  TaxRelatedValues.swift
//  muranakaKadai12
//
//  Created by 村中令 on 2021/11/03.
//

import Foundation

struct TaxRelatedValues {
    var priceExcludingTax: Int
    var consumptionTaxRate: Int
    var priceIncludingTax: Int {
        priceExcludingTax + Int(Float(priceExcludingTax) * Float(consumptionTaxRate) / 100)
    }
}
