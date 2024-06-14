//
//  ProfileViewModel.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/23.
//
import Foundation
import Combine
import Alamofire
import UIKit

let today = Calendar.current.startOfDay(for: Date())

class ProfileViewModel: ObservableObject {
    //認証ができていないのでmockデータを入れている
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
    
    init() {originalData
        userRepository.getUser()
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
    
    func save(userName: String, bikeName: String, profileComment: String) {
        if userName != originalData.userName ||
           bikeName != originalData.bikeName ||
           profileComment != originalData.touringcomment {
            
            userRepository.postUserData(
                userData: UserProfileModel(
                    userName: userName,
                    bikeName: bikeName,
                    profileIcon: originalData.profileIcon,
                    touringcomment: profileComment,
                    createAt: originalData.createAt
                )
            )
            
        }
    }
    
    func loadImage(inputImage: UIImage?) {
        guard let inputImage = inputImage else { return }
        guard let imageData = inputImage.jpegData(compressionQuality: 0.7) else { return }
        userRepository.postUserData(userData: UserProfileModel(
            userName: "",
                bikeName: "",
                profileIcon: imageData,
                touringcomment: ""
            ))
    }
}

