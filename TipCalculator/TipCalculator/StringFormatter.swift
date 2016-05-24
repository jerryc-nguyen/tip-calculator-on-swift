//
//  StringFormatter.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/21/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import Foundation

class StringFormatter {
    class func formatMoneyFor(value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    class func formatMoneyWithCurrencyFor(value: Double, currency: String) -> String {
        let formattedMoney = formatMoneyFor(value)
        return "\(currency) \(formattedMoney)"
    }
}