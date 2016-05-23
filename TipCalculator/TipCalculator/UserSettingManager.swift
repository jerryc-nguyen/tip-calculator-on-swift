//
//  UserSettingManager.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/23/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import Foundation

class UserSettingManager {
    let userSettings = NSUserDefaults.standardUserDefaults()
    
    let currencyKey = "settings_currency"
    let minTipPercentKey = "settings_min_tip_percent"
    let maxTipPercentKey = "settings_max_tip_percent"
    
    let currencies_map: [Int: String] = [
        0: "VND",
        1: "$"
    ]
    
    let DEFAULT_CURRENCY = 1
    let DEFAULT_MIN_TIP = Float(20)
    let DEFAULT_MAX_TIP = Float(80)
    
    var currencyLabel: String {
        get {
            return currencies_map[selectedCurrencyIndex]!
        }
    }
    
    var selectedCurrencyIndex: Int {
        get {
            return userSettings.integerForKey(currencyKey)
        }
    }
    
    var minTipPercent: Float {
        get {
            return userSettings.floatForKey(minTipPercentKey)
        }
    }
    
    var maxTipPercent: Float {
        get {
            return userSettings.floatForKey(maxTipPercentKey)
        }
    }
    
    init() {
        let updatedMinTip = userSettings.floatForKey(minTipPercentKey)
        if updatedMinTip == 0 {
            userSettings.setFloat(DEFAULT_MIN_TIP, forKey: minTipPercentKey)
        }
        
        let updatedMaxTip = userSettings.floatForKey(maxTipPercentKey)
        if updatedMaxTip == 0 {
            userSettings.setFloat(DEFAULT_MAX_TIP, forKey: maxTipPercentKey)
        }
    }
    
    func updateMinTipPercentSetting(newMinTipPercent: Float) {
        userSettings.setFloat(newMinTipPercent, forKey: minTipPercentKey)
    }
    
    func updateMaxTipPercentSetting(newMaxTipPercent: Float) {
        userSettings.setFloat(newMaxTipPercent, forKey: maxTipPercentKey)
    }
    
    func updateCurrencySetting(newCurrencyIndex: Int) {
        userSettings.setInteger(newCurrencyIndex, forKey: currencyKey)
    }
}