//
//  UIKitExtensions.swift
//  PopUpTest
//
//  Created by Gazolla on 02/10/15.
//  Copyright © 2015 Gazolla. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    class func constraintsWithVisualFormat(visualFormat: String, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: [], metrics: nil, views: views)
    }
    
    class func constraintsWithVisualFormat(visualFormat: String,  metrics: [String : AnyObject]?, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: [], metrics: metrics, views: views)
    }
    
    class func constraintsWithVisualFormat(visualFormat: String,  options: NSLayoutFormatOptions, views: [String : AnyObject]) -> [AnyObject] {
        return NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: options, metrics: nil, views: views)
    }
}

extension UIView {
    
    // Given an item, stretches the width and height of the view to the toItem.
    func  stretchToBoundsOfSuperView() -> [NSLayoutConstraint] {
        let constraints =
        NSLayoutConstraint.constraintsWithVisualFormat("H:|[item]|", options: [], metrics: nil, views: ["item" : self]) +
            NSLayoutConstraint.constraintsWithVisualFormat("V:|[item]|", options: [], metrics: nil, views: ["item" : self])
        if let superview = self.superview {
            superview.addConstraints(constraints)
        }
        return constraints
    }
    
    func alignTopTo(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func centerHorizontallyTo(toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerHorizontallyTo(toItem, padding: 0)
    }
    
    func centerHorizontallyTo(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func centerVerticallyTo(toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerVerticallyTo(toItem, padding: 0)
    }
    
    func centerVerticallyTo(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func stretchToWidthOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[item]|", options: [], metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToWidthOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-padding-[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToHeightOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[item]|", options: [], metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func stretchToHeightOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-padding-[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToTopOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-padding-[item]", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToLeftOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-padding-[item]", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToBottomOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainToRightOfSuperView(padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[item]-padding-|", options: [], metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    func constrainWidth(width: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[item(width)]", metrics: ["width" : width], views: ["item" : self])
        self.superview?.addConstraints(constraints as! [NSLayoutConstraint])
        return constraints as! [NSLayoutConstraint]
    }
    
    func constrainHeight(height: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item(height)]", metrics: ["height" : height], views: ["item" : self])
        self.superview?.addConstraints(constraints as! [NSLayoutConstraint])
        return constraints as! [NSLayoutConstraint]
    }
    
    func constrainWidthTo(toItem: UIView) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func constrainHeightTo(toItem: UIView) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToBottom(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToRight(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func anchorToTop(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    func anchorToLeft(toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Left , multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    func isIpad()->Bool{
        return UIScreen.mainScreen().bounds.width >= 768
    }
    
    func adjustToDevice(iPad:CGFloat, iP4: CGFloat, iP5:CGFloat, iP6:CGFloat, iP6S:CGFloat)->CGFloat{
        
        switch (UIScreen.mainScreen().bounds.width) {
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
            if UIScreen.mainScreen().bounds.height == 568 { print("iPhone 5"); return iP5 }
            else { print("iPhone 4"); return iP4 }
        default:
            return iP4
        }
    }
}

extension UIButton {
    
    static func makeButton(title:String, tag:Int, hasBackground:Bool, target:AnyObject?, action:Selector) -> UIButton{
        let blue =  UIColor(red: 0.133, green: 0.376, blue: 0.533, alpha: 1.000)
        let b = UIButton()
        b.tag = tag
        b.translatesAutoresizingMaskIntoConstraints = false
        if hasBackground {
            b.backgroundColor = blue
            b.layer.cornerRadius = 5
        } else {
            b.setTitleColor(blue, forState: UIControlState.Normal)
        }
        b.setTitle(title, forState: UIControlState.Normal)
        b.titleLabel!.font =  UIFont(name: "AmericanTypewriter-Bold" , size: 20)
        b.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return b
    }
    
    static func makeImageButton(imageName:String, tag:Int, hasBackground:Bool, target:AnyObject?, action:Selector) -> UIButton{
        let b = UIButton()
        b.tag = tag
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.backgroundColor = UIColor.clearColor()
        b.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        b.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return b
    }
    
    static func buttonAnimation(sender:UIButton){
        let bgColor = sender.backgroundColor
        
        UIView.animateWithDuration(NSTimeInterval(0.1), delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            sender.backgroundColor = UIColor.blackColor()
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(NSTimeInterval(0.1), animations: { () -> Void in
                    if sender.respondsToSelector(Selector("backgroundColor")) {
                        sender.backgroundColor = bgColor}
                    }, completion: { (Bool) -> Void in })
        }
        
    }
}

