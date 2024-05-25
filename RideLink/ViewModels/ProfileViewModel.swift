//
//  ProfileViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/23.
//
import Foundation
import Combine

//一旦前回作成したモデルの形式で残してる
class ProfileData: ObservableObject {
    @Published var username: String
    @Published var bikename: String
    @Published var comment: String

    init(username: String, bikename: String, comment: String) {
        self.username = username
        self.bikename = bikename
        self.comment = comment
    }
}

class ProfileViewModel: ObservableObject {
    @Published var originalData: ProfileData
    @Published var editData: ProfileData
    @Published var canSave: Bool = false

    init(originalData: ProfileData) {
        self.originalData = originalData
        self.editData = 
            ProfileData(
                username: originalData.username, 
                bikename: originalData.bikename, 
                comment: originalData.comment
            )//変更前の状態を保持

        Publishers
            .CombineLatest3($editData.map(\.username), $editData.map(\.bikename), $editData.map(\.comment))
                .map { [unowned self] (newUsername, newBikename, newComment) in
                    return !newUsername.isEmpty &&
                        !newBikename.isEmpty &&
                        !newComment.isEmpty &&
                        (newUsername != self.originalData.username ||
                            newBikename != self.originalData.bikename ||
                            newComment != self.originalData.comment)
                }
                .assign(to: &$canSave)
    }

    func save() {
        originalData =
            ProfileData(
                username: editData.username,
                bikename: editData.bikename,
                comment: editData.comment
            )//変更前の状態を保持

    }
}
