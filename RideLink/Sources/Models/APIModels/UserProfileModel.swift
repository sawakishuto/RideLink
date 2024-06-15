//
//  UserProfileModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation

struct UserProfileModel: Codable {
    let userName: String
    let bikeName: String
    var profileIcon: Data?
    let touringcomment: String?
    var createAt = Date()
}
