//
//  CustomTableViewCell.swift
//  getCurrency
//
//  Created by Gazolla on 09/01/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    var currency:Currency?{
        didSet{
            
            if let imgPath = Bundle.main.path(forResource: currency!.countryCode!, ofType: "png"){
                self.imageView?.image = UIImage(named: imgPath)
            }
            
            let curString = NSMutableAttributedString(string: "\(currency!.currencyCode!) - \(currency!.currencyName!)", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            curString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location:0,length:4))
            
            self.textLabel?.attributedText = curString
            self.detailTextLabel?.text = "\(currency!.countryName!)"
            self.detailTextLabel?.textColor = UIColor.lightGray
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
