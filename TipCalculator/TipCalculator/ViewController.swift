//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/21/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var tipViewContainer: UIView!
    @IBOutlet weak var lbPlusSign: UILabel!
    @IBOutlet weak var lbEqualSize: UILabel!
    
    let userSettings = UserSettingManager()
    
    let tipCalculator = TipCalculator(billAmount: 0, tipPercent: 0)
    
    let tipSliderStep: Float = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingDataToView()
        hideTipViewController()
        switchToLightTheme()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentSlider.minimumValue = userSettings.minTipPercent
        tipPercentSlider.maximumValue = userSettings.maxTipPercent
        checkThemeChanged()
    }
    
    @IBAction func onBillAmountChanged(sender: AnyObject) {
        handleBillAmountChanged()
    }
    
    @IBAction func onTipPercentChanged(sender: UISlider) {
        let roundedValue = round(sender.value / tipSliderStep) * tipSliderStep
        sender.value = roundedValue
        handleBillAmountChanged()
    }
    
    func checkThemeChanged() {
        if userSettings.selectedThemeIndex == 0 {
            switchToLightTheme()
        } else {
            switchToDarkTheme()
        }
    }
    
    func switchToLightTheme() {
        UIView.animateWithDuration(0.4, animations: {
            self.view.backgroundColor = UIColor(red: 0.2314, green: 0.8941, blue: 0.9294, alpha: 1.0)
            self.tipViewContainer.backgroundColor = UIColor(red: 0.6784, green: 0.9686, blue: 0.9686, alpha: 1.0)
            let textColor = UIColor.blackColor()
            self.changeTipLabelsColorTo(textColor)
        })
    }
    
    func switchToDarkTheme() {
        UIView.animateWithDuration(0.4, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0.4078, blue: 0.5098, alpha: 1.0)
            self.tipViewContainer.backgroundColor = UIColor(red: 0, green: 0.7373, blue: 0.8196, alpha: 1.0)
            let textColor = UIColor.whiteColor()
            self.changeTipLabelsColorTo(textColor)
        })
    }
    
    func changeTipLabelsColorTo(color: UIColor) {
        self.totalLabel.textColor = color
        self.tipLabel.textColor = color
        self.tipValueLabel.textColor = color
        self.lbPlusSign.textColor = color
        self.lbEqualSize.textColor = color
    }
    
    func handleBillAmountChanged() {
        tipCalculator.billAmount = NSString(string: billField.text!).doubleValue
        tipCalculator.tipPercent = Int(tipPercentSlider.value)
        bindingDataToView()
        
        if tipCalculator.billAmount != 0 {
            fadeInTipViewContainer()
            moveBillFieldUp()
        } else {
            fadeOutTipViewContainer()
            moveBillFieldDown()
        }
    }
    
    func hideTipViewController() {
        self.tipViewContainer.alpha = 0
    }
    
    func showTipViewController() {
        self.tipViewContainer.alpha = 1
    }
    
    func fadeInTipViewContainer() {
        UIView.animateWithDuration(0.4, animations: {
            self.showTipViewController()
            self.tipViewContainer.frame.origin.y = 150
        })
    }
    
    func moveBillFieldUp() {
        UIView.animateWithDuration(0.4, animations: {
            self.billField.frame.origin.y = 110
        })
    }
    
    func moveBillFieldDown() {
        UIView.animateWithDuration(0.4, animations: {
            self.billField.frame.origin.y = 180
        })
    }
    
    func fadeOutTipViewContainer() {
        UIView.animateWithDuration(0.4, animations: {
            self.hideTipViewController()
            self.tipViewContainer.frame.origin.y = 200
        })
    }
    
    func bindingDataToView() {
        let selectedCurrency = userSettings.currencyLabel
        
        tipValueLabel.text = StringFormatter.formatMoneyWithCurrencyFor(tipCalculator.tip, currency: selectedCurrency)
        totalLabel.text = StringFormatter.formatMoneyWithCurrencyFor(tipCalculator.total, currency: selectedCurrency)
        let selectedTipPercent = Int(tipPercentSlider.value)
        tipLabel.text = "Tip: \(selectedTipPercent)%"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

