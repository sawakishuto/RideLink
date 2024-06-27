//
//  EndPoints.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/15.
//

import Foundation

enum paths: String {
    case createUser = "/user/create" //SignUp時User情報作成
    case userData = "/user" //User情報を取得(Get), 更新(Put)
    case getFriend = "/user/friend/list" //　フレンド情報取得
    case sendFriendReq = "/user/friend/request/:uuid"
    case touringStart = "/user/touring/start" //ツーリングスタート
    case touringEnd = "/touring/end" //終了
    case encount = "/user/passings" //すれ違い情報取得
    case location = "/user/location" //位置情報送信
    case token = "/user/deviceToken/register "
}
