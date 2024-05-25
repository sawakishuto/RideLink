//
//  UserRepositoryProtocol.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine

protocol UserRepositoryProtocol: AnyObject {
//    uidを使ってUser情報を取得するメソッド

    func getUserData() -> AnyPublisher<UserProfileModel, Error>

    func getFriendData() -> AnyPublisher<FriendInfoModel, Error>



// それぞれ情報をProfileViewからアップデートできるputメソッドを作成してほしい（もしいけるならデータをジェネリクス(汎用性が高い型)として持って一つのメソッドでいろんな情報のアップデートに使えるととてもベスト！！）
//    更新が成功したらenvirnomentObjectにも変更が加わるようにしてほしい!

//    func updateUserName(uid: String, name: String)
//
//    func updataBikeName(uid: String, bikeName: String)

}
