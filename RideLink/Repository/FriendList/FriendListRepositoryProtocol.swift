//
//  FriendListRepositoryProtocol.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/06/16.
//

import Foundation
import Combine

protocol FriendListRepositoryProtocol: AnyObject {
    func getFriendList() -> AnyPublisher<[FriendInfoModel],Error>
}
