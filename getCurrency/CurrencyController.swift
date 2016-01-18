//
//  CurrencyController.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var currencies:[Currency] = Currency().loadEveryCountryWithCurrency()
    var filteredCountries:[Currency] = []
    var tableView:UITableView?
    
    var leftButton:  UIBarButtonItem?
    var searchButton: UIBarButtonItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.setupTableView()

        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.searchBar.sizeToFit()
        

        self.tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    }
    
    // MARK: - UISearchBarDelegate

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
        self.tableView?.reloadData()
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
           // self.searchController.view.removeFromSuperview()
            self.tableView!.tableHeaderView = nil
            }) { (Bool) -> Void in
                
                self.navigationItem.rightBarButtonItem = self.searchButton
        }
    }


    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
         filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
    
    
    func setupNavBar(){
        self.title = "Select one currency:"
        
        self.leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "dismissTapped:")
         self.searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "searchCurrency:")
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.rightBarButtonItem = self.searchButton
    }
    
    func searchCurrency(sender:UIButton){
        self.searchController.searchBar.alpha = 1
        self.searchController.searchBar.becomeFirstResponder()

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.tableView!.tableHeaderView = self.searchController.searchBar
            self.tableView!.setContentOffset(CGPointMake(0, -64), animated: false)
            self.searchController.searchBar.text = ""
        })
        
    }
    
    func dismissTapped(sender:UIButton){
        self.dismissViewControllerAnimated(true) {}
    }
    
    
    func setupTableView(){
        self.tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        self.tableView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView!.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
