//
//  AppDelegate.swift
//  ePECS
//
//  Created by ITLabAdmin on 5/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootVC: UIViewController?
    private var sb: UIStoryboard?
    var navigationController: UINavigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupNavigationBar()
        sb = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        navigationController = sb?.instantiateInitialViewController() as! UINavigationController
        
        print(UserDefaults.standard.integer(forKey: "defaultVC"))
        let defaultLevel = UserDefaults.standard.integer(forKey: "defaultVC")
        switch defaultLevel {
        case 1:
            sb = UIStoryboard(name: "FirstLevelStoryboard", bundle: nil)
            rootVC = sb?.instantiateViewController(withIdentifier: "FirstLevelViewController") as! FirstLevelViewController
            break
        case 2:
            sb = UIStoryboard(name: "SecondLevelStoryboard", bundle: nil)
            rootVC = sb?.instantiateViewController(withIdentifier: "SecondLevelViewController") as! SecondLevelViewController
            break
        case 3:
            sb = UIStoryboard(name: "ThirdLevelStoryboard", bundle: nil)
            rootVC = sb?.instantiateViewController(withIdentifier: "ThirdLevelCategoryViewController") as! ThirdLevelCategoryViewController
            break
        case 4:
            sb = UIStoryboard(name: "FourthLevelStoryboard", bundle: nil)
            rootVC = sb?.instantiateViewController(withIdentifier: "FourthLevelCategoryViewController") as! FourthLevelCategoryViewController
            break
        default:
            sb = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
            rootVC = sb?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            break
        }
        navigationController.viewControllers = [rootVC] as! [UIViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor(red: 218, green: 68, blue: 83)
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 218, green: 68, blue: 83),
                                                            NSAttributedStringKey.font: UIFont(name: "OpenSans-Bold", size: 16)!]
    }
}

//extension AppDelegate {
//    static var shared: AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }
//
//    var rootViewController: RootViewController {
//        return window!.rootViewController as! RootViewController
//    }
//}

