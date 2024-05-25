//
//  TouringInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


struct TouringInfoModel: Codable {
    let destinationName: String?
    let destinationLatitude: Double?
    let destinationLongitude: Double?
    let isOnline: Bool
}
