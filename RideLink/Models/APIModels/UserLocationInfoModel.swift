//
//  UserLocationInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation




import Foundation

struct LocatinInfo: Codable {
    let latitude: Double
    let longitude: Double
    var createAt: String

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.createAt = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

            let now = Date()
            let formattedDate = dateFormatter.string(from: now)
            return formattedDate
        }()
    }
}

