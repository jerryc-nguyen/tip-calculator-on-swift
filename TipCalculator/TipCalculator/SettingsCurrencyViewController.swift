//
//  SettingsCurrencyViewController.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/22/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import UIKit

class SettingsCurrencyViewController: UITableViewController {
    
    let userSettings = UserSettingManager()
    
    @IBOutlet var currencyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == userSettings.selectedCurrencyIndex {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        uncheckAllCells()
        let selectedIndex = indexPath.row
        currencyTable.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark
        userSettings.updateCurrencySetting(selectedIndex)
    }
    
    func uncheckAllCells() {
        for cell in currencyTable.visibleCells {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
}
