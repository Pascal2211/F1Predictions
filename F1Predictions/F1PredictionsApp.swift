//
//  F1PredictionsApp.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 02/08/2024.
//

import SwiftUI
import Firebase

@main
struct F1PredictionsApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
