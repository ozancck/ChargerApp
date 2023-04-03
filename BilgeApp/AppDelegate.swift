//
//  AppDelegate.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import Foundation
import UIKit
import Firebase
pDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
