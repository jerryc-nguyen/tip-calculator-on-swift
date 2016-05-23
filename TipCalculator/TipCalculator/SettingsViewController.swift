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
    
    
    let userSettings = UserSettingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lbSelectedCurrency.text = userSettings.currencyLabel
        sliderMinTipPercent.value = userSettings.minTipPercent
        sliderMaxTipPercent.value = userSettings.maxTipPercent
        sycMinTipPercentToView()
        sycMaxTipPercentToView()
    }
    
    @IBAction func onMinTipPercentChanged(sender: UISlider) {
        userSettings.updateMinTipPercentSetting(sender.value)
        sycMinTipPercentToView()
    }
    
    @IBAction func onMaxTipPercentChanged(sender: UISlider) {
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
    
}
