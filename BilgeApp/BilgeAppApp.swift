//
//  BilgeAppApp.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import FirebaseCore
import SwiftUI

@main
struct BilgeAppApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginHomeView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
