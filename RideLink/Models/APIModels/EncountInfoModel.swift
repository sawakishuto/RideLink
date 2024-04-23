//
//  EncountInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


struct EncountInfoModel: Codable {
    let userInfo: UserProfileModel
    let touringInfo: TouringInfoModel
    let encountLocationLatitude: Double
    let encountLocationLongitude: Double
}
