//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/21/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    let tipCalculator = TipCalculator(billAmount: 0, tipPercent: 0)
    let tipPercentages = [0.18, 0.2, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        syncLatestDataToView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBillAmountChanged(sender: AnyObject) {
        tipCalculator.billAmount = NSString(string: billField.text!).doubleValue
        tipCalculator.tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        syncLatestDataToView()
    }

    @IBAction func onTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func syncLatestDataToView() {
        tipLabel.text = StringFormatter.formatMoneyFor(tipCalculator.tip)
        totalLabel.text = StringFormatter.formatMoneyFor(tipCalculator.total)
    }
}

