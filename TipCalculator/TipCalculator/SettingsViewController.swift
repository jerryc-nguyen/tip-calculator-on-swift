//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/22/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var lbSelectedCurrency: UILabel!
    
    @IBOutlet weak var sliderMinTipPercent: UISlider!
    
    @IBOutlet weak var sliderMaxTipPercent: UISlider!
    
    @IBOutlet weak var tooggleTheme: UISwitch!
    
    @IBOutlet weak var lbMinTipPercent: UILabel!
    
    @IBOutlet weak var lbMaxTipPercent: UILabel!
    
    @IBOutlet weak var themeSwitcher: UISwitch!
    
    @IBOutlet weak var lbSelectedTheme: UILabel!
    
    let userSettings = UserSettingManager()
    
    let tipSliderStep: Float = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        syncCurrencyToView()
        sliderMinTipPercent.value = userSettings.minTipPercent
        sliderMaxTipPercent.value = userSettings.maxTipPercent
        sycMinTipPercentToView()
        sycMaxTipPercentToView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        syncCurrencyToView()
        switchToSelectedTheme()
        bindindThemeTypeToLabel()
    }
    
    @IBAction func onMinTipPercentChanged(sender: UISlider) {
        let roundedValue = round(sender.value / tipSliderStep) * tipSliderStep
        sender.value = roundedValue
        userSettings.updateMinTipPercentSetting(sender.value)
        sycMinTipPercentToView()
    }
    
    @IBAction func onMaxTipPercentChanged(sender: UISlider) {
        let roundedValue = round(sender.value / tipSliderStep) * tipSliderStep
        sender.value = roundedValue
        userSettings.updateMaxTipPercentSetting(sender.value)
        sycMaxTipPercentToView()
    }
    
    func sycMinTipPercentToView() {
        let minValue = Int(sliderMinTipPercent.value)
        lbMinTipPercent.text = "Min tip percent: \(minValue)%"
    }
    
    func sycMaxTipPercentToView() {
        let maxValue = Int(sliderMaxTipPercent.value)
        lbMaxTipPercent.text = "Max tip percent: \(maxValue)%"
    }
    
    func syncCurrencyToView() {
        lbSelectedCurrency.text = userSettings.currencyLabel
    }
    
    @IBAction func onThemeSwitched(sender: UISwitch) {
        if sender.on {
            userSettings.updateThemeTypeSetting(0)
        } else {
            userSettings.updateThemeTypeSetting(1)
        }
        bindindThemeTypeToLabel()
    }
    
    func bindindThemeTypeToLabel() {
        lbSelectedTheme.text = userSettings.selectedThemeType
    }
    
    func switchToSelectedTheme() {
        themeSwitcher.on = userSettings.selectedThemeIndex == 0
    }
    
}
