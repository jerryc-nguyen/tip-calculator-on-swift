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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBillAmountChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let selectTipValue = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * selectTipValue
        let total = billAmount + tip
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }

    @IBAction func onTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

