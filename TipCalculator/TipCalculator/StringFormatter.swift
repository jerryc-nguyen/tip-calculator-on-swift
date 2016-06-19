//
//  StringFormatter.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/21/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import Foundation

class StringFormatter {
    class func formatMoneyWithCurrencyFor(value: Double, countryLocaleId: String) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyAccountingStyle
        formatter.locale = NSLocale(localeIdentifier: countryLocaleId)
        return formatter.stringFromNumber(value)!
    }
}