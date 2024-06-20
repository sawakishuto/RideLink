//
//  ContentViewModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/21.
//

import Foundation
import UserNotifications

final class ContentViewModel: ObservableObject {
    @Published var isRecieveNotification: Bool = false
    @Published var count: Int = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("RecieveNotification"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        print(userInfo)
        let encounter = userInfo["encounter"] as! Int
        isRecieveNotification = true
        count = encounter
        sendLocalNotification(count: encounter)
    }

    func sendLocalNotification(count: Int) {
        let content = UNMutableNotificationContent()
        content.title = "すれ違いがありました！"
        content.body = "\(count)人とすれ違いました！👍"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("通知の送信に失敗しました: \(error.localizedDescription)")
            } else {
                print("通知を送信しました")
            }
        }
    }

}

