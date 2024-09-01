//
//  FriendListViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/06/16.
//

import Foundation
import Combine



final class FriendListViewModel: ObservableObject{
    @Published var friendList : [FriendInfoModel] = []
    let friendListRepository = FriendListRepository()
    private var cancellables = Set<AnyCancellable>()

    init() {
        
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
            }
            .store(in: &cancellables)

        //mockリストを生成
        var isOnline = true
    }
    

}

