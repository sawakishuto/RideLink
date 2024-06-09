//
//  ProfileViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/23.
//
import Foundation
import Combine
import Alamofire

class ProfileViewModel: ObservableObject {
    @Published var originalData: UserProfileModel = UserProfileModel(
        userName: "kaka",
        bikeName: "yzf",
        profileIcon: nil,
        touringcomment: "hello",
        createAt: today
    )
    @Published var canSave: Bool = false
    let userRepository = UserRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        userRepository.getUserData()
            .sink { response  in
                switch response {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    return
                }
            } receiveValue: { [weak self] userProfile in
                self?.originalData = userProfile
            }.store(in: &cancellables)
    }
    
    func validationData(userName: String, bikeName: String, userComment: String) -> Result<Bool, Error> {
        if userName.isEmpty || bikeName.isEmpty {
            return .success(false)
        }
        return .success(true)
    }

    func save(userName: String, bikeName: String, userComment: String) {
        // 保存処理を実行する必要がある場合、ここに記述
        //userRepository.updateUserData(userProfile: updatedProfile)
    }
}

