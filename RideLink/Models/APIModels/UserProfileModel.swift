//
//  UserProfileModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation

struct UserProfileAPIModel: Codable {
    let uid: String
    let userName: String
    let bikeName: String
    let profileIcon: URL
    let createAt: Date
}
