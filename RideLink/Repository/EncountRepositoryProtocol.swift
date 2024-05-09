//
//  EncountRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/10.
//

import Foundation

protocol EncountRepositoryProtocol {
    func fetchEncounters(uid: String)
    func sendFriendRequest(ownUid uid: String, recipientUid uid: String)
    func saveEncounters(encounterInfo: EncounterInfo)
    func deleteEncounters(encounterUid: String)
}
