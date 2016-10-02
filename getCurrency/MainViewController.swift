//
//  MainViewController.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    lazy var getCurrencyButton:UIButton = {
        return UIButton.makeButton("get currency", tag: 222, hasBackground: true, target: self,  action: #selector(MainViewController.btnTapped(_:)))
    }()
    
    lazy var selectedCurrencyTableView:UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tv.dataSource = self
        tv.delegate = self
        tv.keyboardDismissMode = .onDrag
        tv.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    
    lazy var currencyCell:CurrencyCell = {
        let currencyCell = CurrencyCell()
        currencyCell.translatesAutoresizingMaskIntoConstraints = false
        return currencyCell
    }()
    
    lazy var currencyCtrl:CurrencyController = {
        return CurrencyController()
    }()
    
    var currencies:[Currency] = [] {
        didSet {
            self.selectedCurrencyTableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.selectedCurrency(_:)), name: NSNotification.Name(rawValue: "selectedCurrency"), object: nil)
         
        self.view.addSubview(self.getCurrencyButton)
        self.view.addConstraints(getCurrencyButton.constrainToTopOfSuperView(200))
        self.view.addConstraints(getCurrencyButton.centerHorizontallyTo(self.view))
        self.view.addConstraints(getCurrencyButton.constrainWidth(200))
        self.view.addConstraints(getCurrencyButton.constrainHeight(50))
        
        
        self.view.addSubview(selectedCurrencyTableView)
        self.view.addConstraints(selectedCurrencyTableView.constrainToBottomOfSuperView(100))
        self.view.addConstraints(selectedCurrencyTableView.centerHorizontallyTo(self.view))
        self.view.addConstraints(selectedCurrencyTableView.constrainWidth(self.view.bounds.width-20))
        self.view.addConstraints(selectedCurrencyTableView.constrainHeight(200))
     }
    
    func selectedCurrency(_ notification:Notification){
        self.currencies = notification.object as! [Currency]
    }
    
    func btnTapped(_ sender:UIButton){
        let navCtrl = UINavigationController(rootViewController: self.currencyCtrl)
        self.navigationController!.present(navCtrl, animated: true) {}
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//PRAGMA MARK: - TableView Methods
extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        let currency:Currency = self.currencies[(indexPath as NSIndexPath).row]
    
        cell.currency = currency
        
        return cell
    }
    
}

