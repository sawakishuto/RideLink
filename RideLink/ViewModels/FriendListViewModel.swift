//
//  FriendListViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/06/16.
//

import Foundation
import Combine

let mockProfile = UserProfileModel(
    userName: "カカ",
    bikeName: "yzf-r15",
    profileIcon: nil,
    touringcomment: "教養リーチ！",
    createAt: today
)

final class FriendListViewModel: ObservableObject{
    @Published var friendList : [FriendInfoModel] = []
    let friendListRepository = FriendListRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {friendList
        
        friendListRepository.getFriendList()
            .sink {response in
                switch response {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    return
                }
                
            } receiveValue: { [weak self]  receiveValue in
                self?.friendList = receiveValue
            }.store(in: &cancellables)
        
        //mockリストを生成
        var isOnline = true
        for _ in 1...8 {
            let friend = FriendInfoModel(id: UUID().uuidString, isOnline: isOnline, profile: mockProfile)
            friendList.append(friend)
            isOnline.toggle()
        }
    }
    

}

