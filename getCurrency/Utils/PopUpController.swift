//
//  PopUpController.swift
//  PopUpTest
//
//  Created by Gazolla on 02/10/15.
//  Copyright © 2015 Gazolla. All rights reserved.
//

import UIKit

class PopUpController: UIViewController {
    
    let blue =  UIColor(red: 0.133, green: 0.376, blue: 0.533, alpha: 1.000)
    var constraintVertically:NSLayoutConstraint?
    var outOffScreen:CGFloat = -1000.0
    var blurView:UIVisualEffectView?
    var height:CGFloat = UIScreen.mainScreen().bounds.height
    var width:CGFloat = UIScreen.mainScreen().bounds.width
    var tapView:UITapGestureRecognizer?
    var tapBlurView:UITapGestureRecognizer?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.tapView = UITapGestureRecognizer(target: self, action: "tapView:")
        self.view.addGestureRecognizer(self.tapView!)
        
        self.view.superview!.addConstraints(self.view.constrainHeight(self.height))
        self.view.superview!.addConstraints(self.view.constrainWidth(self.width))
        
        self.view.superview!.addConstraints(self.view.centerHorizontallyTo(view.superview!))
        self.constraintVertically = self.view.centerVerticallyTo(view.superview!)[0]
        self.view.superview!.addConstraints([self.constraintVertically!])
        self.constraintVertically!.constant = self.outOffScreen
        
        let blurEffect = UIBlurEffect(style: .Light)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView!.frame = self.view.superview!.bounds
        self.blurView!.translatesAutoresizingMaskIntoConstraints = false
        self.blurView!.alpha = 0.0
        self.tapBlurView = UITapGestureRecognizer(target: self, action: "tapView:")
        self.blurView!.addGestureRecognizer(self.tapBlurView!)

        
    }
    
    func tapView(gesture:UITapGestureRecognizer){
        self.dismissViewController({})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("PopUpController: didReceiveMemoryWarning")
    }
    
    
    func showViewController(fn:()->()){
        self.constraintVertically?.constant = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.superview!.layoutIfNeeded()
            self.view.layoutIfNeeded()

            }) { (Bool) -> Void in
                self.view.superview!.addSubview(self.blurView!)
                self.view.superview!.bringSubviewToFront(self.view)
 
                UIView.animateWithDuration(0.3) { () -> Void in
                     self.blurView!.alpha = 1.0
                    fn()
                }
        }
    }
    
    func dismissViewController(fn:()->()){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.constraintVertically?.constant = self.outOffScreen
            self.view.superview!.layoutIfNeeded()
        }) { (Bool) -> Void in
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.blurView!.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    self.blurView!.removeFromSuperview()
                    fn()
            })
        }
    }
    
}
