//
//  APIError.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/15.
//

import Foundation

enum APIError: Error {
    case decodeError
    case invalidUrl
    case networkError
    case unknown
    case forbidden
    case auth

    var title: String {
        switch self {

        case .invalidUrl:
            return "URLが無効です."
        case .networkError:
            return "ネットワークエラー"
        case .unknown:
            return "不明なエラー"
        case .decodeError:
            return "デコードエラー"
        case .forbidden:
            return "パーミッションエラー"
        case .auth:
            return "認証エラー"
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
        case .decodeError:
            return "デコードに失敗しました"
        case .forbidden:
            return "アクセス権がありません"
        case .auth:
            return "認証に失敗しました"
        }
    }
}
