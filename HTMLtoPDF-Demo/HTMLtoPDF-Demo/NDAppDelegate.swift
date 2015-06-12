//
//  NDAppDelegate.m
//  HTMLtoPDF-Demo
//
//  Created by Clément Wehrung on 12/11/12.
//  Copyright (c) 2012 Nurves. All rights reserved.
//
//  *******************************************************************************************
//  *                                                                                         *
//  **This code has been automaticaly ported to Swift language 1.2 using MyAppConverter.com  **
//  *                                     11/06/2015                                          *
//  *******************************************************************************************

import UIKit

@UIApplicationMain
class NDAppDelegate :UIResponder,UIApplicationDelegate
{
    var viewController:NDViewController?
    var window:UIWindow?
    func application( application:UIApplication ,didFinishLaunchingWithOptions launchOptions:[NSObject : AnyObject]?)->Bool{
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone  {
            self.viewController = NDViewController(nibName:"NDViewController_iPhone" , bundle:nil )
            
            
        }
        else
        {
            self.viewController = NDViewController(nibName:"NDViewController_iPad" , bundle:nil )
            
        }
        
        self.window?.rootViewController = self.viewController
        self.window?.makeKeyAndVisible()
        return true
        
    }
    func applicationWillResignActive( application:UIApplication ){
    }
    func applicationDidEnterBackground( application:UIApplication ){
    }
    func applicationWillEnterForeground( application:UIApplication ){
    }
    func applicationDidBecomeActive( application:UIApplication ){
    }
    func applicationWillTerminate( application:UIApplication ){
    }
}