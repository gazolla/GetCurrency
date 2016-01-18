//
//  CircleController.swift
//  Coutdown
//
//  Created by Gazolla on 05/10/15.
//  Copyright © 2015 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit
import AVFoundation

class CountDownController: UIViewController {
    
    var bck:UIView?
    var countLabel:UILabel?
    var count:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size:CGFloat = 150.0 // 35.0 chosen arbitrarily
        let blue =  UIColor(red: 0.133, green: 0.376, blue: 0.533, alpha: 1.0)
        
        self.bck = UIView()
        self.bck!.bounds = CGRectMake(0.0, 0.0, size, size)
        self.bck!.layer.cornerRadius = size / 2
        self.bck!.layer.borderWidth = 6.0
        self.bck!.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.bck!.layer.borderColor = blue.CGColor
        self.bck!.center = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/4)
         self.view.addSubview(self.bck!)
        
        self.countLabel = UILabel()
        self.countLabel!.textColor = blue
        self.countLabel!.textAlignment = .Center
        self.countLabel!.font = UIFont.systemFontOfSize(70)
        self.countLabel!.bounds = CGRectMake(0.0, 0.0, size, size)
        self.countLabel!.center = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/4)
        self.view.addSubview(self.countLabel!)
        
    }
    
    func start(){
        self.playM4aFromBundleString("beep")
        UIView.animateWithDuration(0.9, animations: { () -> Void in
            self.countLabel!.alpha = 0.0
            self.countLabel!.text = "3"
            self.countLabel!.alpha = 1.0
            }) { (Bool) -> Void in
                self.playM4aFromBundleString("beep")
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.countLabel!.alpha = 0.0
                    self.countLabel!.text = "2"
                    self.countLabel!.alpha = 1.0
                    
                    }, completion: { (Bool) -> Void in
                        self.playM4aFromBundleString("beep")
                        UIView.animateWithDuration(0.9, animations: { () -> Void in
                            self.countLabel!.alpha = 0.0
                            self.countLabel!.text = "1"
                            self.countLabel!.alpha = 1.0
                            
                            }, completion: { (Bool) -> Void in
                                self.playM4aFromBundleString("beep")
                                UIView.animateWithDuration(0.9, animations: { () -> Void in
                                    self.countLabel!.alpha = 0.0
                                    self.countLabel!.text = "0"
                                    self.countLabel!.alpha = 1.0
                                    
                                    }, completion: { (Bool) -> Void in
                                        self.playM4aFromBundleString("finalBeep")
                                        UIView.animateWithDuration(0.9, animations: { () -> Void in
                                            self.countLabel!.alpha = 0.0
                                            self.countLabel!.text = "Já!"
                                            self.countLabel!.alpha = 1.0
                                            
                                            }, completion: { (Bool) -> Void in
                                                UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                    self.countLabel!.alpha = 0.0
                                                    self.bck!.alpha = 0.0
                                                    }, completion: { (Bool) -> Void in
                                                        self.view.removeFromSuperview()
                                                })
                                        })
                                })
                        })
                })
        }

    }
    
    func start(var c:Int, fn:()->()){
        UIView.animateWithDuration(0.9, animations: { () -> Void in
            if c >= 0 {
                self.countLabel!.alpha = 0.0
                self.countLabel!.text = "\(c)"
                self.countLabel!.alpha = 1.0
            } else {
                self.countLabel!.alpha = 0.0
                self.bck!.alpha = 0.0
            }
        }) { (Bool) -> Void in
            if c >= 0 {
                self.playM4aFromBundleString((c == 0) ? "finalBeep" : "beep")
                self.start(c, fn: {fn()})
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.countLabel!.alpha = 0.0
                    self.bck!.alpha = 0.0
                    }, completion: { (Bool) -> Void in
                        self.view.removeFromSuperview()
                        fn()
                })
            }
        }
        c--
        
    }
    
    func playM4aFromBundleString(name:String) {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType:"m4a") {
            let url = NSURL.fileURLWithPath(path)
            var soundID:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url, &soundID);
            AudioServicesPlaySystemSound(soundID);
        } else {
            print("não encontrado")
        }
        
    }

    
}