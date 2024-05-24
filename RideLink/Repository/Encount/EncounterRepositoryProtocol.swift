//
//  EncounterRepositoryProtocol.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine


protocol EncounterRepositoryProtocol: AnyObject {

    func sendFriendReqest(ownUid: String, toUid: String) -> AnyPublisher<Bool, Error>

    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error>

    func acceptFriendRequest(ownUid: String, toUid: String) -> AnyPublisher<Bool, Error>
//    誰とすれ違ったかを取得するメソッド
    func getEncountInfo() -> AnyPublisher<[EncountInfoModel], Error>
//   自分の位置をポストするメソッド
    func postUserLocation(userLocInfo: UserLocationInfoModel) -> AnyPublisher<Bool, Error>
}