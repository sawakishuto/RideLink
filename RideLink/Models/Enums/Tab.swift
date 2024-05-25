//
//  ViewEnum.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import Foundation

enum Tab: CaseIterable {
    case map
    case encounts
    case friends
    case settings
}
extension Tab {
    func synbolName() -> String {
        switch self {

        case .map:
            "map"
        case .encounts:
            "repeat"
        case .friends:
            "person.2"
        case .settings:
            "gearshape"
        }
    }
}
