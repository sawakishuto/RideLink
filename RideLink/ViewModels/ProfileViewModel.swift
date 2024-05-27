//
//  ProfileViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/23.
//
import Foundation
import Combine

class EditData: ObservableObject {
    @Published var username: String
    @Published var bikename: String
    @Published var comment: String?

    init(username: String, bikename: String, comment: String?) {
        self.username = username
        self.bikename = bikename
        self.comment = comment
    }
}

class ProfileViewModel: ObservableObject {
    @Published var originalData: UserProfileModel
    @Published var editData: EditData
    @Published var canSave: Bool = false

    init(originalData: UserProfileModel) {
        self.originalData = originalData
        self.editData = 
            EditData(
                username: originalData.userName,
                bikename: originalData.bikeName,
                comment: originalData.touringcomment
            )

    let isNotEmptyPublisher = 
        Publishers.CombineLatest3(
            $editData.map(\.username), 
            $editData.map(\.bikename), 
            $editData.map(\.comment)
        )
        .map { (newUsername, newBikename, newComment) in
            return !newUsername.isEmpty && !newBikename.isEmpty && !(newComment ?? "").isEmpty
        }

    let isChangedPublisher = Publishers.CombineLatest3($editData.map(\.username), $editData.map(\.bikename), $editData.map(\.comment))
        .map { [unowned self] (newUsername, newBikename, newComment) in
            return newUsername != self.originalData.userName || newBikename != self.originalData.bikeName || newComment != self.originalData.touringcomment
        }

    Publishers.CombineLatest(isNotEmptyPublisher, isChangedPublisher)
        .map { (isNotEmpty, isChanged) in
            return isNotEmpty && isChanged
        }
        .assign(to: &$canSave)
    }

    func save() {
        originalData =
            UserProfileModel(
                userName: editData.username,
                bikeName: editData.bikename,
                profileIcon: originalData.profileIcon,
                touringcomment: editData.comment,
                createAt: originalData.createAt
            )

        self.canSave = false
    }
}
