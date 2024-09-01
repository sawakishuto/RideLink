//
//  FriendListRepository.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/06/16.
//

import Foundation
import Combine

final class FriendListRepository: FriendListRepositoryProtocol {
    private let apiClient = APIClient.shared
    var cancellables = Set<AnyCancellable>()

    func getFriendList() -> AnyPublisher<[FriendInfoModel], Error> {
        return Deferred {
            Future { promise in
                self.apiClient.fetchData(
                    endPoint: paths.getFriend.rawValue,
                    params: nil,
                    type: [FriendInfoModel].self
                )
                .sink { response in
                    switch response {
                    case.failure(let error):
                        print("FriendLisr response failure")
                    case.finished:
                        print("FriendLisr accept!")
                        return
                    }
                } receiveValue: { result in
                    print("Frienrd List:")
                    print(result)
                    promise(.success(result))
                }
                .store(in: &self.cancellables)
            }
            
        }
        .eraseToAnyPublisher()
        
    }
}
