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
    

    // PRAGMA MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select one currency:"
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.rightBarButtonItem = self.searchButton
        self.view.addSubview(self.tableView)
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
    
    func dismissTapped(_ sender:UIButton){
        self.dismiss(animated: true) {}
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
        
        cell.currency = currency
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency:Currency
        
        if searchController.isActive && searchController.searchBar.text != "" {
            currency = self.filteredCurrencies[(indexPath as NSIndexPath).row]
            searchController.isActive = false
        } else {
            currency = self.currencies[(indexPath as NSIndexPath).row]
        }
        
        self.dismissSearchBar()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "selectedCurrency"), object: currency)
        self.dismiss(animated: true) {}
    }
  
}
