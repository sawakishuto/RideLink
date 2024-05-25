//
//  RideLinkApp.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/03/27.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        TabViews()
          ProfileView(vm: profileViewModel)
      }
    }
  }
}

var profileData = ProfileData(username: "kaka", bikename: "yzf", comment: "hello")

var profileViewModel = ProfileViewModel(originalData: profileData)
