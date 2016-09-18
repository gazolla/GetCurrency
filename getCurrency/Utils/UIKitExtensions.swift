//
//  UIKitExtensions.swift
//  PopUpTest
//
//  Created by Gazolla on 02/10/15.
//  Copyright © 2015 Gazolla. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    class func constraintsWithVisualFormat(_ visualFormat: String, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: nil, views: views)
    }
    
    class func constraintsWithVisualFormat(_ visualFormat: String,  metrics: [String : AnyObject]?, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: metrics, views: views)
    }
    
    class func constraintsWithVisualFormat(_ visualFormat: String,  options: NSLayoutFormatOptions, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: options, metrics: nil, views: views)
    }
}

extension UIView {
    
    // Given an item, stretches the width and height of the view to the toItem.
    func  stretchToBoundsOfSuperView() -> [NSLayoutConstraint] {
        let constraints =
        NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item" : self]) +
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[item]|", options: [], metrics: nil, views: ["item" : self])
        if let superview = self.superview {
            superview.addConstraints(constraints)
        }
        return constraints
    }
    
    func alignTopTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func centerHorizontallyTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerHorizontallyTo(toItem, padding: 0)
    }
    
    func centerHorizontallyTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func centerVerticallyTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerVerticallyTo(toItem, padding: 0)
    }
    
    func centerVerticallyTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func stretchToWidthOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToWidthOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToHeightOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[item]|", options: [], metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToHeightOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToTopOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[item]", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToLeftOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[item]", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToBottomOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToRightOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainWidth(_ width: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[item(width)]", metrics: ["width" : width], views: ["item" : self])
        self.superview?.addConstraints(constraints )
        return constraints 
    }
    
    func constrainHeight(_ height: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[item(height)]", metrics: ["height" : height], views: ["item" : self])
        self.superview?.addConstraints(constraints )
        return constraints 
    }
    
    func constrainWidthTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func constrainHeightTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToBottom(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToRight(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToTop(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    func anchorToLeft(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: toItem, attribute: NSLayoutAttribute.left , multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func isIpad()->Bool{
        return UIScreen.main.bounds.width >= 768
    }
    
    func adjustToDevice(_ iPad:CGFloat, iP4: CGFloat, iP5:CGFloat, iP6:CGFloat, iP6S:CGFloat)->CGFloat{
        
        switch (UIScreen.main.bounds.width) {
        case 414:
            print("iphone 6 Plus")
            return iP6S
        case 768:
            print("iPad")
            return iPad
        case 375:
            print("iPhone 6")
            return iP6
        case 320:
            if UIScreen.main.bounds.height == 568 { print("iPhone 5"); return iP5 }
            else { print("iPhone 4"); return iP4 }
        default:
            return iP4
        }
    }
}

extension UIButton {
    
    static func makeButton(_ title:String, tag:Int, hasBackground:Bool, target:AnyObject?, action:Selector) -> UIButton{
        let blue =  UIColor(red: 0.133, green: 0.376, blue: 0.533, alpha: 1.000)
        let b = UIButton()
        b.tag = tag
        b.translatesAutoresizingMaskIntoConstraints = false
        if hasBackground {
            b.backgroundColor = blue
            b.layer.cornerRadius = 5
        } else {
            b.setTitleColor(blue, for: UIControlState())
        }
        b.setTitle(title, for: UIControlState())
        b.titleLabel!.font =  UIFont(name: "AmericanTypewriter-Bold" , size: 20)
        b.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        return b
    }
    
    static func makeImageButton(_ imageName:String, tag:Int, hasBackground:Bool, target:AnyObject?, action:Selector) -> UIButton{
        let b = UIButton()
        b.tag = tag
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.backgroundColor = UIColor.clearColor()
        b.setBackgroundImage(UIImage(named: imageName), for: UIControlState())
        b.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        return b
    }
    
    static func buttonAnimation(_ sender:UIButton){
        let bgColor = sender.backgroundColor
        
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0.0, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            sender.backgroundColor = UIColor.black
            }) { (Bool) -> Void in
                
                UIView.animate(withDuration: TimeInterval(0.1), animations: { () -> Void in
                    if sender.responds(to: #selector(getter: UIView.backgroundColor)) {
                        sender.backgroundColor = bgColor}
                    }, completion: { (Bool) -> Void in })
        }
        
    }
}

