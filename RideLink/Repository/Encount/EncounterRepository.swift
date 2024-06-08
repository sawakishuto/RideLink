//
//  EncounterRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine
import Alamofire

    let apiClient = APIClient.shared

    func sendFriendReqest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error> {
        let subject = CurrentValueSubject<FriendInfoModel, Error>(FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil)))
        subject.send((FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil))))
        return subject.eraseToAnyPublisher()
    }
