//
//  UserProfileModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation

import Foundation

struct UserProfileModel: Codable {
    let uuid: String?
    var name: String
    var bike: String
    var profileComment: String?
    var iconBase64: String? = nil
    var isTouring: Bool?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case bike
        case profileComment = "profile_comment"
        case iconBase64 = "icon_base64"
        case isTouring = "is_touring"
    }
}
extension UserProfileModel {
    var iconImage: Data? {
        guard let convertImage = Data(base64Encoded: iconBase64 ?? "", options: .ignoreUnknownCharacters) else {
            return nil
        }
        return convertImage
    }
}
struct UserData: Codable {
    let uuid: String
    let name: String
    let bike: String
}

struct PostResponseUserData: Codable {
    let uuid: String
    let name: String
    let bike: String
    let isTouring: Bool? // オプショナルプロパティにする
}
