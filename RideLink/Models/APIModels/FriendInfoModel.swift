//
//  FrendInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


struct FriendInfoModel: Codable, Identifiable {
    let id = UUID().uuidString
    let uuid: String
    let name: String
    let bike: String
    let comment: String?
    let iconBase64: String
    let isTouring: Bool?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case bike
        case comment
        case iconBase64 = "icon_base64"
        case isTouring = "is_touring"
    }
}
