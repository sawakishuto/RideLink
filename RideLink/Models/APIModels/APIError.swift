//
//  APIError.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/15.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case networkError
    case unknown

    var title: String {
        switch self {

        case .invalidUrl:
            return "URLが無効です."
        case .networkError:
            return "ネットワークエラー"
        case .unknown:
            return "不明なエラー"
        }
    }

    var description: String {
        switch self {

        case .invalidUrl:
            return "URLが無効です。"
        case .networkError:
            return "接続環境の良いところでもう一度お試しください。"
        case .unknown:
            return "不明なエラーです。"
        }
    }
}
