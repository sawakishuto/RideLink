//
//  EncountInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


import Foundation

struct EncountInfoModel: Codable, Identifiable {
    let id = UUID().uuidString
    let latitude: Double
    let longitude: Double
    let stayedAt: String
    let uuid: String
    let name: String
    let bike: String
    let passedAt: String

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case stayedAt = "stayed_at"
        case uuid
        case name
        case bike
        case passedAt = "PassedAt"
    }
    var formattedPassedAt: String? {
            return EncountInfoModel.formatDateString(stayedAt)
        }

        static func formatDateString(_ dateString: String) -> String? {
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            guard let date = isoFormatter.date(from: dateString) else {
                return nil
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current

            return dateFormatter.string(from: date)
        }
}
extension EncountInfoModel {

}
