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
            return "map"
        case .encounts:
            return "repeat"
        case .friends:
            return "person.2"
        case .settings:
            return "gearshape"
        }
    }
}
