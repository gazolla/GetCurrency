//
//  MainViewController.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var getCurrencyButton:UIButton?
    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedCurrency:", name: "selectedCurrency", object: nil)
        
        self.getCurrencyButton = UIButton.makeButton("get currency", tag: 222, hasBackground: true, target: self)
        self.view.addSubview(self.getCurrencyButton!)
        self.view.addConstraints(getCurrencyButton!.constrainToTopOfSuperView(200))
        self.view.addConstraints(getCurrencyButton!.centerHorizontallyTo(self.view))
        self.view.addConstraints(getCurrencyButton!.constrainWidth(200))
        self.view.addConstraints(getCurrencyButton!.constrainHeight(50))
        
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        
        self.view.addConstraints(textView.constrainToBottomOfSuperView(100))
        self.view.addConstraints(textView.centerHorizontallyTo(self.view))
        self.view.addConstraints(textView.constrainWidth(self.view.bounds.width-20))
        self.view.addConstraints(textView.constrainHeight(200))
     }
    
    func selectedCurrency(notification:NSNotification){
        self.textView.text = ""
        let currency = notification.object as! Currency
        print("\(currency.print())")
        self.textView.text = "\(currency.print())"
    }
    
    func btnTapped(sender:UIButton){
        let currencyCtrl = CurrencyController()
        let navCtrl = UINavigationController(rootViewController: currencyCtrl)
        self.navigationController!.presentViewController(navCtrl, animated: true) {}
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
