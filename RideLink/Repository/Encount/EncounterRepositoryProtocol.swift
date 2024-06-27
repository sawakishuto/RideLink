//
//  EncounterRepositoryProtocol.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine


protocol EncounterRepositoryProtocol: AnyObject {

    func sendFriendReqest(toUid: String) -> AnyPublisher<Bool, Error>

//    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error>

    func acceptFriendRequest(toUid: String) -> AnyPublisher<Bool, Error>
//    誰とすれ違ったかを取得するメソッド
    func getEncountInfo() -> AnyPublisher<[EncountInfoModel], Error>
//   自分の位置をポストするメソッド
    func postUserLocation(userLocInfo: [LocatinInfo]) -> AnyPublisher<Bool, Error>

    func postTouringCondition(touringCondition: TouringInfoModel) 

    func postTouringEnd()
}
