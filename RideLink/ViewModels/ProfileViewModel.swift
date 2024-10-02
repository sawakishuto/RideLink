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
    @Published var originalData: UserProfileModel = UserProfileModel(uuid: nil, name: "", bike: "", iconBase64: "", isTouring: false)
    @Published var canSave: Bool = false
    @Published var iconImageData: Data? = nil
    let userRepository = UserRepository()
    private var cancellables: Set<AnyCancellable> = []

    func getUserProfile() {
        userRepository.getUser()
            .sink { response  in
                switch response {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    return
                }
            } receiveValue: { [weak self] userProfile in
                guard let self = self else {return}
                self.originalData = userProfile
                self.iconImageData = userProfile.iconImage
            }
            .store(in: &cancellables)
    }


    
    func save(userName: String, bikeName: String, profileComment: String, completion: @escaping() -> Void) {
        if userName != originalData.name ||
            bikeName != originalData.bike ||
            profileComment != originalData.profileComment {
            print(originalData.iconBase64)
            userRepository.putUserData(
                userData: UserProfileModel(
                    uuid: originalData.uuid ?? "0",
                    name: userName,
                    bike: bikeName,
                    profileComment: profileComment,
                    iconBase64: originalData.iconBase64,
                    isTouring: originalData.isTouring ?? false
                )
            )
            .sink { result in
                switch result {
                case .finished:
                    completion()
                    print("UserData Post End")
                    return
                case .failure(let error):
                    print("UserData Post Failure")
                    return
                }
            } receiveValue: { user in
                completion()
            }
            .store(in: &cancellables)

        }
        print("保存します")
    }
    
    func loadImage(inputImage: UIImage?) {
        guard let inputImage = inputImage else {
            print("UIImageじゃない")
            return }
        guard let imageData = inputImage.jpegData(compressionQuality: 0.7) else { return }
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        print("データを保存します")
        originalData.iconBase64 = base64String
        userRepository.putUserData(userData: UserProfileModel(
            uuid: originalData.uuid ?? "",
            name: originalData.name ?? "" ,
            bike: originalData.bike ?? "",
            profileComment: originalData.profileComment ?? "",
            iconBase64: base64String,
            isTouring: originalData.isTouring ?? false)
        )
        .sink { result in
            switch result {
            case .finished:
                print("UserData Post End")
                return
            case .failure(let error):
                print("UserData Post Failure")
                return
            }
        } receiveValue: { user in
            self.iconImageData = user?.iconImage
        }
        .store(in: &cancellables)

    }
}

