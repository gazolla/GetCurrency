//
//  currency.swift
//  getCurrency
//
//  Created by Gazolla on 08/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class Currency: NSObject {
    
    var countryName:String?
    var countryCode:String?
    var currencyCode:String?
    var currencySymbol:String?
    var currencyName:String?
    
    func loadEveryCountryWithCurrency() -> [Currency] {
        var result:[Currency]=[]
        let currencies = NSLocale.commonISOCurrencyCodes()
        for currencyCode in currencies {
            
            let currency = Currency()
            currency.currencyCode = currencyCode
            
            let currencyLocale : NSLocale  = NSLocale(localeIdentifier: currencyCode)
            currency.currencyName = currencyLocale.displayNameForKey(NSLocaleCurrencyCode, value: currencyCode)
            currency.countryCode = String(currencyCode.characters.prefix(2))
            
            let countryLocale  = NSLocale.currentLocale()
            currency.countryName = countryLocale.displayNameForKey(NSLocaleCountryCode, value: currency.countryCode!)
            
            if currency.countryName != nil {
                result.append(currency)
            }
            
        }
        return result
    }
    
    
    func print()->String{
        return  "\nCountryCode   : \(self.countryCode!)\nName         : \(self.countryName!)\nCurrencyCode : \(self.currencyCode!)\nSymbol       : \(self.currencySymbol)\ncurrencyName: \(self.currencyName!)\n----------------------------"
    }
    
 }
