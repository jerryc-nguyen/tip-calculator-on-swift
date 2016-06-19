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
    var allCountries = [Locale]()
    
    
    @IBOutlet var tblCountries: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allCountries = Array(self.userSettings.countriesMap.values).sort({ $0.countryName < $1.countryName })
        
        self.tblCountries.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tblCountryCell")
        self.tblCountries.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSettings.countriesMap.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "tblCountryCell")
        
        let currentDisplayCountry = allCountries[indexPath.row]
        cell.textLabel?.text = currentDisplayCountry.countryName
        cell.detailTextLabel?.text = currentDisplayCountry.countryCurrency
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if allCountries[indexPath.row].countryCode == userSettings.selectedCountryCode {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        uncheckAllCells()
        let selectedCountryCode = allCountries[indexPath.row].countryCode
        tblCountries.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark
        userSettings.updateCurrencySetting(selectedCountryCode)
    }
    
    func uncheckAllCells() {
        for cell in tblCountries.visibleCells {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    
}
