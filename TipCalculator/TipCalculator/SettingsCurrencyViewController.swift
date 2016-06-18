//
//  SettingsCurrencyViewController.swift
//  TipCalculator
//
//  Created by Nguyen Nhan on 5/22/16.
//  Copyright © 2016 Nguyen Nhan. All rights reserved.
//

import UIKit

class SettingsCurrencyViewController: UIViewController, UITableViewDataSource {
    
    let userSettings = UserSettingManager()


    @IBOutlet var tblCountries: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblCountries.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tblCountryCell")
        self.tblCountries.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSettings.settingsCountries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "tblCountryCell")
        let currentDisplayCountry = self.userSettings.settingsCountries[indexPath.row]
        
        cell.textLabel?.text = currentDisplayCountry.countryName
        cell.detailTextLabel?.text = currentDisplayCountry.countryCurrency
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == userSettings.selectedCurrencyIndex {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        uncheckAllCells()
        let selectedIndex = indexPath.row
        tblCountries.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark
        userSettings.updateCurrencySetting(selectedIndex)
    }
    
    func uncheckAllCells() {
        for cell in tblCountries.visibleCells {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    
}
