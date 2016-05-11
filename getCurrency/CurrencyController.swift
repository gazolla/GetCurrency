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
        let tv = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tv.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        tv.dataSource = self
        tv.delegate = self
        tv.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    lazy  var leftButton:  UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: #selector(CurrencyController.dismissTapped(_:)))
    }()

    lazy var searchButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(CurrencyController.searchCurrency(_:)))
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension CurrencyController:UISearchBarDelegate, UISearchResultsUpdating {
    // PRAGMA MARK: - UISearchBarDelegate
    func filterContentForSearchText(searchText: String) {
        self.filteredCurrencies = currencies.filter{ currency in
            let stringMatch = currency.currencyName!.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        }
        self.tableView.reloadData()
    }
    
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
         self.dismissSearchBar()
    }
    
    func dismissSearchBar(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
             self.searchController.searchBar.alpha = 0
            }) { (Bool) -> Void in
                self.title = "Select one currency:"
                self.navigationItem.rightBarButtonItem = self.searchButton
        }
    }


    //PRAGMA MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
         filterContentForSearchText(searchController.searchBar.text!)
    }

    //PRAGMA MARK: - search event Method
    func searchCurrency(sender:UIButton){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = self.searchController.searchBar
            self.searchController.searchBar.alpha = 1
            self.searchController.searchBar.becomeFirstResponder()
            self.searchController.searchBar.text = ""
        })
    }
    
    func dismissTapped(sender:UIButton){
        self.dismissViewControllerAnimated(true) {}
    }
}

//PRAGMA MARK: - TableView Methods
extension CurrencyController:UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return self.filteredCurrencies.count
        }
        return self.currencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? CustomTableViewCell
        
        let currency:Currency
        
        if searchController.active && searchController.searchBar.text != "" {
            currency = self.filteredCurrencies[indexPath.row]
        } else {
            currency = self.currencies[indexPath.row]
        }
        
        if let imgPath = NSBundle.mainBundle().pathForResource(currency.countryCode!, ofType: "png"){
            cell!.imageView?.image = UIImage(named: imgPath)
        }
        let curString = NSMutableAttributedString(string: "\(currency.currencyCode!) - \(currency.currencyName!)", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
        curString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSRange(location:0,length:4))
        
        cell!.textLabel?.attributedText = curString
        cell!.detailTextLabel?.text = "\(currency.countryName!)"
        cell!.detailTextLabel?.textColor = UIColor.lightGrayColor()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currency:Currency
        
        if searchController.active && searchController.searchBar.text != "" {
            currency = self.filteredCurrencies[indexPath.row]
            searchController.active = false
        } else {
            currency = self.currencies[indexPath.row]
        }
        
        self.dismissSearchBar()
        NSNotificationCenter.defaultCenter().postNotificationName("selectedCurrency", object: currency)
        self.dismissViewControllerAnimated(true) {}
    }
  
}
