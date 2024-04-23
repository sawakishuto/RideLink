//
//  UserLocationInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


struct UserLocationInfoModel: Codable {
    let uid: String
    let latitude: Double
    let longitude: Double
    var createAt = Date()
}
