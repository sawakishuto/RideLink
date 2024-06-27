import SwiftUI
import FirebaseCore
import UserNotifications


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let encountRepository = EncounterRepository()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Firebaseの初期化
        FirebaseApp.configure()
        // 画面に自動ロックがかからないよに設定
        UIApplication.shared.isIdleTimerDisabled = true
        // 通知の許可をリクエスト
        print("通知の許可をリクエスト")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("通知の許可リクエストでエラーが発生しました: \(error)")
                return
            }
            if granted {
                DispatchQueue.main.async {
                    print("通知の許可が得られました")
                    UIApplication.shared.registerForRemoteNotifications()
                    print("UIApplication.shared.registerForRemoteNotifications()が呼ばれました")
                }
            } else {
                print("通知の許可が得られませんでした")
            }
        }

        UNUserNotificationCenter.current().delegate = self

        return true
    }



    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(#function)
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
        APIClient.shared.postDeviceToken(endPoint: paths.token.rawValue, params: ["device_token": "\(token)"])
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error.localizedDescription)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    }

    func handleNotification(userInfo: [AnyHashable: Any]) {
        NotificationCenter.default.post(name: Notification.Name("RecieveNotification"), object: nil, userInfo: userInfo)
    }
}
extension AppDelegate {

    // backgroundでpaylaodを受け取った時

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        let aps = userInfo["aps"] as! [String: Any]
        let contentAvailable  = aps["content-available"] as!  Int
        if contentAvailable == 1 {
            print("サイレントプッシュ")
            if userInfo["title"] as! String == "テスト" {
                handleNotification(userInfo: userInfo)
            }
        } else {
            print("失敗")
        }
    }
}


@main
struct RideLinkApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabViews()
            }
        }
    }
}
