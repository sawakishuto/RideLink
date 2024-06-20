//
//  ContentView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/03/27.
//

import SwiftUI

struct ContentView: View {
    @State private var notificationPayload: [AnyHashable: Any]?
    @ObservedObject var vm = ContentViewModel()


    var body: some View {
        GeometryReader { geometory in

            ZStack(alignment: .center){

                if vm.isRecieveNotification {
                    bannerNotification(encountCount: vm.count, isRecieveNotification: $vm.isRecieveNotification)
                        .position(
                            x: geometory.size.width * 0.56,
                            y: geometory.size.height * 0.6
                        )
                        .zIndex(100)
                }

                MapView()
            }
            .ignoresSafeArea()
        }
        .onAppear {
            sendLocalNotification()
        }
    }
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "すれ違いがありました！"
        content.body = "10人とすれ違いました！👍"

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


    #Preview {
        ContentView()
    }
