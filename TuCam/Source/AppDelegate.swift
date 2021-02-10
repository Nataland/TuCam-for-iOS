//
//  AppDelegate.swift
//  TuCam
//
//  Created by Natalie Zhang on 2021-02-08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
		let navController = UINavigationController(rootViewController: HomeViewController())
		window?.rootViewController = navController
		window?.makeKeyAndVisible()
        return true
    }
}

