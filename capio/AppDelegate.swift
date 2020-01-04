//
//  AppDelegate.swift
//  capio
//
//  Created by Roman on 7/10/16.
//  Copyright © 2016 theroman. All rights reserved.
//

import UIKit
import ElasticTransition

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CAAnimationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = mainStoryboard.instantiateViewController(withIdentifier: "FirstViewController")
        self.window!.rootViewController = firstViewController
        self.window!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.window!.makeKeyAndVisible()
        
        // logo mask
        firstViewController.view.layer.mask = CALayer()
        firstViewController.view.layer.mask?.contents = UIImage(named: "cio_inapp_ico_new")!.cgImage
        firstViewController.view.layer.mask?.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        firstViewController.view.layer.mask?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        firstViewController.view.layer.mask?.position = CGPoint(x: firstViewController.view.frame.width / 2, y: firstViewController.view.frame.height / 2)

        // logo mask background view
        let maskBgView = UIView(frame: firstViewController.view.frame)
        maskBgView.backgroundColor = UIColor.white
        firstViewController.view.addSubview(maskBgView)
        firstViewController.view.bringSubview(toFront: maskBgView)

        // logo mask animation
        let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimation.delegate = self
        transformAnimation.duration = 1
        transformAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(cgRect: (firstViewController.view.layer.mask?.bounds)!)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 40, height: 40))
        let thirdBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 5000, height: 5000))
        transformAnimation.values = [initalBounds, secondBounds, thirdBounds, finalBounds]
        transformAnimation.keyTimes = [0, 0.3, 0.6, 1]
        transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        transformAnimation.isRemovedOnCompletion = false
        transformAnimation.fillMode = kCAFillModeForwards
        firstViewController.view.layer.mask?.add(transformAnimation, forKey: "maskAnimation")

        // logo mask background view animation
        UIView.animate(withDuration: 0.1,
                       delay: 1.35,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        maskBgView.alpha = 0.0
                       },
                       completion: { finished in
                        maskBgView.removeFromSuperview()
                       })

        // root view animation
        UIView.animate(withDuration: 0.25,
                       delay: 1.3,
                       options: [],
                       animations: {
                        self.window!.rootViewController!.view.transform = CGAffineTransform(scaleX: 1.0005, y: 1.0005)
                       },
                       completion: { finished in
                        UIView.animate(withDuration: 0.3,
                                       delay: 0.0,
                                       options: UIViewAnimationOptions.curveEaseInOut,
                                       animations: {
                                        self.window!.rootViewController!.view.transform = .identity
                                       },
                                       completion: { finished in firstViewController.view.layer.mask = nil})
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

