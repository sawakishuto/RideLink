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
    func postUserData(userData userProfile: UserProfileModel) -> AnyPublisher<UserProfileModel?, Error> {
        let parameter: Parameters = [
            "name": "しゅうと",
            "bike": "DSC400",
            "icon_base64": "iVBORw0KGgoAAAANSUhEUgAAACUAAAAjCAIAAACcpVRJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE7SURBVFhH5Zc9EoIwEEa9/2E8ARdInYKCOmUaCtr1g6BmN1lINNEZfbONzsJjl/xxoc/yv755IefITGs4v/7UWDP9M+b97yw53+xoMHRNw9Lo95wAHiibOUyaNfGNVl4sYr/XQuYs04U7MrjPTfKafFilASJsWmXsW8ruUhODrDHylRZXGdwY+UyS2iQMG2IPn5d5rYK3tL/vOu2GjbsPc07mtQo2Sr/l69jPT/uy7w90mg/K+CxYOV+LkW0ska9LS1kzQezrUCIvDnBf2yU7WayB8AHfSCk7GUh94O0qsScrZH2gYPvWgm8IAs23Ub0jWnL6sWrj0Afm4tepn5FiznyB03kizm06ZT6gbiCZQ9EBxT6A3kpZUQ9janyAKesqC1T6wKOxmdXjnHofwAfDwefEIS/53uC3fUQ3aVbgpAsXEskAAAAASUVORK5CYII="
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
