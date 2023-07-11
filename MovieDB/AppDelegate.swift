//
//  AppDelegate.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var mainComposer: MainComposer?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController()
    mainComposer = MainComposer(container: DIContainer.configure())
    mainComposer?.startApp(with: navigationController)
    
    window!.rootViewController = navigationController
    window!.makeKeyAndVisible()
    
    return true
  }


}

