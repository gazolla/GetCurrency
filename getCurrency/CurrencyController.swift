//
//  CurrencyController.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
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
    
    var currencies:[Currency] = Currency().loadEveryCountryWithCurrency()
    var filteredCountries:[Currency] = []
    var leftButton:  UIBarButtonItem?
    var searchButton: UIBarButtonItem?

    // PRAGMA MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // PRAGMA MARK: - Setup Method
    func setup(){
        self.title = "Select one currency:"
        
        self.leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "dismissTapped:")
        self.searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "searchCurrency:")
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.rightBarButtonItem = self.searchButton
        
        self.view.addSubview(self.tableView)
    }

    
    // PRAGMA MARK: - UISearchBarDelegate
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredCountries = currencies.filter{ currency in
            
            let result = currency.currencyName!.lowercaseString.rangeOfString(searchText.lowercaseString ,
                options: NSStringCompareOptions.LiteralSearch,
                range: currency.currencyName!.startIndex..<currency.currencyName!.endIndex,
                locale: nil)
            
             if let _ = result {
                return true
             } else {
                return false
            }
         }
        self.tableView.reloadData()
    }
    
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: "")
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
         filterContentForSearchText(searchController.searchBar.text!, scope: "")
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
    
    //PRAGMA MARK: - TableVIew Method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return self.filteredCountries.count
        }
        return self.currencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? CustomTableViewCell
        
        let currency:Currency
        
        if searchController.active && searchController.searchBar.text != "" {
            currency = self.filteredCountries[indexPath.row]
        } else {
            currency = self.currencies[indexPath.row]
        }
        
        let imgPath = NSBundle.mainBundle().pathForResource(currency.countryCode!, ofType: "png")
        
        if imgPath != nil {cell!.imageView?.image = UIImage(named: imgPath!)}
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
            currency = self.filteredCountries[indexPath.row]
            searchController.active = false
        } else {
            currency = self.currencies[indexPath.row]
        }
        
        self.dismissSearchBar()
        NSNotificationCenter.defaultCenter().postNotificationName("selectedCurrency", object: currency)
        self.dismissViewControllerAnimated(true) {}
    }
    

}
