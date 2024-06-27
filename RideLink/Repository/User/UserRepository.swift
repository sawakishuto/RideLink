//
//  UserRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Alamofire
import Combine

final class UserRepository: UserRepositoryProtocol {
    private let apiClient = APIClient.shared
    
    func getUser() -> AnyPublisher<UserProfileModel, Error> {
        return Deferred {
            Future { promise in
                print(#function)
                self.apiClient.fetchData(
                    endPoint: paths.createUser.rawValue,
                    params: nil,
                    type: UserProfileModel.self
                )
                .sink { response in
                    switch response {
                    case.failure(let error):
                        print("🎉31")
                        promise(.failure(error))
                    case .finished:
                        print("🎉22")
                        return
                    }
                    print(response)
                } receiveValue: { result in
                    print(result)
                    print("🎉44")
                    
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    func postUserData(userData userProfile: UserProfileModel) -> AnyPublisher<UserProfileModel, Error> {
        let parameter: Parameters = [
            "name": "\(String(describing: userProfile.userName))",
            "bike": "\(String(describing: userProfile.bikeName))",
            "icon_base64": "\(String(describing: userProfile.profileIcon))"
        ]
        return Deferred {
            
            Future { promise in
                self.apiClient.postData(
                    endPoint: paths.createUser.rawValue,
                    params: parameter,
                    type: UserProfileModel.self
                )
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print("postUserDataで失敗: \(error.localizedDescription)")
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                } receiveValue: { result in
                    print("postUserData成功: \(result)")
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

