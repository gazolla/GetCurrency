//
//  CurrencyController.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController{
    
    // PRAGMA MARK: - Properties
    lazy var searchController:UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.dimsBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.alpha = 0
        self.definesPresentationContext = true
        search.searchBar.sizeToFit()
        return search
    }()

    lazy var tableView:UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tv.dataSource = self
        tv.delegate = self
        tv.keyboardDismissMode = .onDrag
        tv.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    lazy  var leftButton:  UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(CurrencyController.dismissTapped(_:)))
    }()

    lazy var searchButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(CurrencyController.searchCurrency(_:)))
    }()
    
    var currencies:[Currency] = Currency().loadEveryCountryWithCurrency()
    var filteredCurrencies:[Currency] = []
    var selectedCurrencies:[String:Currency] = [:]
    

    // PRAGMA MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.searchBar.alpha = 0
        self.navigationItem.rightBarButtonItem = self.searchButton
        self.title = "Select one currency:"
    }
    
 }


extension CurrencyController:UISearchBarDelegate, UISearchResultsUpdating {
    // PRAGMA MARK: - UISearchBarDelegate
    func filterContentForSearchText(_ searchText: String) {
        self.filteredCurrencies = currencies.filter{ currency in
            let stringMatch = currency.currencyName!.lowercased().range(of: searchText.lowercased())
            return (stringMatch != nil)
        }
        self.tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         self.dismissSearchBar()
    }
    
    func dismissSearchBar(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
             self.searchController.searchBar.alpha = 0
            }) { (Bool) -> Void in
                self.title = "Select one currency:"
                self.navigationItem.rightBarButtonItem = self.searchButton
        }
    }


    //PRAGMA MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
         filterContentForSearchText(searchController.searchBar.text!)
    }

    //PRAGMA MARK: - search event Method
    func searchCurrency(_ sender:UIButton){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = self.searchController.searchBar
            self.searchController.searchBar.alpha = 1
            self.searchController.searchBar.becomeFirstResponder()
            self.searchController.searchBar.text = ""
        })
    }
    
    func dismissTapped(_ sender:UIBarButtonItem){
        self.searchController.isActive = false

        self.dismiss(animated: true) {
            let currencies:[Currency] =  self.selectedCurrencies.map{ $0.1 }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "selectedCurrency"), object:currencies)
        }
    }
}

//PRAGMA MARK: - TableView Methods
extension CurrencyController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredCurrencies.count
        }
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        
        let currency:Currency
        if searchController.isActive && searchController.searchBar.text != "" {
            currency = self.filteredCurrencies[(indexPath as NSIndexPath).row]
        } else {
            currency = self.currencies[(indexPath as NSIndexPath).row]
        }
        
        if selectedCurrencies.count > 0 {
            let selected = selectedCurrencies[currency.currencyCode!]
            if selected != nil {
                cell.accessoryType = .checkmark
            }
        }
        
        cell.currency = currency
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency:Currency
        
        if searchController.isActive && searchController.searchBar.text != "" {
            currency = self.filteredCurrencies[(indexPath as NSIndexPath).row]
        } else {
            currency = self.currencies[(indexPath as NSIndexPath).row]
        }
        
        selectCurrency(tableView, indexPath, currency)
    }
    
    func selectCurrency(_ tableView: UITableView, _ indexPath: IndexPath, _ currency: Currency){
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                selectedCurrencies[currency.currencyCode!] = currency
            } else {
                cell.accessoryType = .none
                selectedCurrencies.removeValue(forKey: currency.currencyCode!)
            }
        }
    }
  
}
