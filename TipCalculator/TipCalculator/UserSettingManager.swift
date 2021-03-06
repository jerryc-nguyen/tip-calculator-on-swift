//
//  UserSettingManager.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/23/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import Foundation

struct Locale {
    let countryLocaleId: String
    let countryCode: String
    let countryName: String
    let countryCurrency: String
}

class UserSettingManager {
    let userSettings = NSUserDefaults.standardUserDefaults()
    
    let currencyKey = "settings_currency"
    let minTipPercentKey = "settings_min_tip_percent"
    let maxTipPercentKey = "settings_max_tip_percent"
    let themeTypeKey = "settings_theme_type"
    let lastSavedBilledAmountAtKey = "settings_last_saved_billed_amount_at"
    let billAmountKey = "settings_bill_amount_key"
    
    var countriesMap = [String: Locale]()
    
    let themesMap: [Int: String] = [
        0: "Light theme",
        1: "Dark theme"
    ]
    
    let DEFAULT_CURRENCY = 1
    let DEFAULT_MIN_TIP = Float(20)
    let DEFAULT_MAX_TIP = Float(80)
    let DEFAULT_THEME_TYPE = 0
    
    var currencyLabel: String {
        get {
            return countriesMap[selectedCountryCode]!.countryCurrency
        }
    }
    
    var selectedCountryLocaleId: String {
        get {
            return countriesMap[selectedCountryCode]!.countryLocaleId
        }
    }
    
    var selectedCountryCode: String {
        get {
            return userSettings.stringForKey(currencyKey)!
        }
    }
    
    var selectedThemeIndex: Int {
        get {
            return userSettings.integerForKey(themeTypeKey)
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
    
    var selectedThemeType: String {
        get {
            return themesMap[selectedThemeIndex]!
        }
    }
    
    var savedBillAmount: String {
        get {
            let lastSavedAt = userSettings.doubleForKey(lastSavedBilledAmountAtKey)
            let timeDiff = NSDate().timeIntervalSince1970 - lastSavedAt
            let timeThresholdSecond = Double(10 * 60)
            
            if timeDiff > timeThresholdSecond {
                return ""
            } else {
                return userSettings.stringForKey(billAmountKey)!
            }
        }
    }
    
    init() {
        
        buildCountriesMap()
        
        let updatedMinTip = userSettings.floatForKey(minTipPercentKey)
        if updatedMinTip == 0 {
            userSettings.setFloat(DEFAULT_MIN_TIP, forKey: minTipPercentKey)
        }
        
        let updatedMaxTip = userSettings.floatForKey(maxTipPercentKey)
        if updatedMaxTip == 0 {
            userSettings.setFloat(DEFAULT_MAX_TIP, forKey: maxTipPercentKey)
        }
    }
    
    func buildCountriesMap() {
        let locales = NSLocale
            .availableLocaleIdentifiers()
            .map { NSLocale(localeIdentifier: $0) }
            .filter {
                let localeCurrencyCode = $0.objectForKey(NSLocaleCountryCode)
                
                if localeCurrencyCode != nil {
                    let countryCodeStr = localeCurrencyCode as! String
                    let countryCurrency = $0.objectForKey(NSLocaleCurrencySymbol) as! String
                    return NSLocale.ISOCountryCodes().indexOf(countryCodeStr) != nil && countryCurrency.characters.count == 1
                } else {
                    return false
                }
            }
            .map {
                Locale(
                    countryLocaleId: $0.localeIdentifier,
                    countryCode: $0.objectForKey(NSLocaleCountryCode) as! String,
                    countryName: NSLocale.systemLocale().displayNameForKey(NSLocaleCountryCode, value: $0.objectForKey(NSLocaleCountryCode) as! String)!,
                    countryCurrency: $0.objectForKey(NSLocaleCurrencySymbol) as! String
                )
        }.sort({ $0.countryName < $1.countryName })
        
        
        for country in locales {
            countriesMap[country.countryCode] = country
        }
    }
    
    func updateMinTipPercentSetting(newMinTipPercent: Float) {
        userSettings.setFloat(newMinTipPercent, forKey: minTipPercentKey)
    }
    
    func updateMaxTipPercentSetting(newMaxTipPercent: Float) {
        userSettings.setFloat(newMaxTipPercent, forKey: maxTipPercentKey)
    }
    
    func updateCurrencySetting(countryCode: String) {
        userSettings.setValue(countryCode, forKey: currencyKey)
    }
    
    func updateThemeTypeSetting(newThemeIndex: Int) {
        userSettings.setInteger(newThemeIndex, forKey: themeTypeKey)
    }
    
    func updateLastSavedBilledAmountAt() {
        let interval = NSDate().timeIntervalSince1970
        userSettings.setDouble(interval, forKey: lastSavedBilledAmountAtKey)
    }
    
    func updateBillAmount(billAmount: String) {
        userSettings.setValue(billAmount, forKey: billAmountKey)
        updateLastSavedBilledAmountAt()
    }
    
}