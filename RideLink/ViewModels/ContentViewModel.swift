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

