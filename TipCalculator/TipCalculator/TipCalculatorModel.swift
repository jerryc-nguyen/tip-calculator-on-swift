//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/21/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import Foundation

class TipCalculator {
    
    var billAmount: Double
    
    var tipPercent: Double
    
    var tip: Double {
        get {
            return calculateTipBy(self.tipPercent)
        }
    }
    
    var total: Double {
        get {
            return billAmount + tip
        }
    }
    
    init(billAmount: Double, tipPercent: Double) {
        self.billAmount = billAmount
        self.tipPercent = tipPercent
    }
    
    func calculateTipBy(tipPercent: Double) -> Double {
        return self.billAmount * tipPercent
    }
    
    
}