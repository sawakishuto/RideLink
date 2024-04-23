//
//  UserProfileModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation

struct UserProfileModel: Codable {
    let uid: String
    let userName: String
    let bikeName: String
    let profileIcon: String
    let comment: String
    var createAt = Date()
}
