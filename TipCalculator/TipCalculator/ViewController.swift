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
    
    let userSettings = UserSettingManager()
    
    let tipCalculator = TipCalculator(billAmount: 0, tipPercent: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingDataToView()
        hideTipViewController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentSlider.minimumValue = userSettings.minTipPercent
        tipPercentSlider.maximumValue = userSettings.maxTipPercent
    }
    
    @IBAction func onBillAmountChanged(sender: AnyObject) {
        tipCalculator.billAmount = NSString(string: billField.text!).doubleValue
        tipCalculator.tipPercent = Int(tipPercentSlider.value)
        bindingDataToView()
        
        if tipCalculator.billAmount != 0 {
            fadeInTipViewContainer()
        } else {
            fadeOutTipViewContainer()
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

