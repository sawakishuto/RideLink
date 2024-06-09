//
//  EncounterRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine
import Alamofire

final class EncounterRepository: EncounterRepositoryProtocol {

    let apiClient = APIClient.shared

    func sendFriendReqest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    func postTouringEnd() {
        apiClient.fetchData(endPoint: paths.touringEnd.rawValue, params: nil, type: TouringInfoModel.self)
    }


    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error> {
        let subject = CurrentValueSubject<FriendInfoModel, Error>(FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil)))
        subject.send((FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil))))
        return subject.eraseToAnyPublisher()
    }

    func getEncountInfo() -> AnyPublisher<[EncountInfoModel], Error> {
        return Deferred {
            Future { promise in
                self.apiClient.fetchData(endPoint: paths.encount.rawValue, params: nil, type: EncountResponse.self)
                    .receive(on: DispatchQueue.global(qos: .background))
                    .sink { response in
                        switch response {
                        case.failure(let error):
                            promise(.failure(error))
                        case .finished:
                            return
                        }
                    } receiveValue: { result in
                        promise(.success(result.encountInfos))
                    }

            }
        }
        .eraseToAnyPublisher()
    }

    func acceptFriendRequest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }
    
    func postUserLocation(userLocInfo: [LocatinInfo]) -> AnyPublisher<Bool, Error> {
        print(#function)
        var locInfoParam: [String: [[String: Any]]] = ["locInfo": [[:]]]

        var locationInfo: [[String: Any]] = [[:]]

        for info in userLocInfo {
            locationInfo.append([
                "latitude": "\(info.latitude)",
                "longitude": "\(info.longitude)",
                "stayed_at": "\(info.createAt)"
            ])
        }
        locInfoParam["locInfo"] = locationInfo

        return Deferred {
            Future { promise in
                self.apiClient.postDatas(endPoint: paths.location.rawValue, params: locInfoParam, type: UserLocationInfoModel.self)
            }
        }
        .eraseToAnyPublisher()
    }

    func postTouringCondition(touringCondition: TouringInfoModel) {
        print(#function)
        var param: Parameters = [
            "destination": "\(touringCondition.destinationName)",
            "touring_comment": "\(touringCondition.touringComment)"
        ]

        apiClient.postData(endPoint: paths.touringStart.rawValue, params: param, type: TouringInfoModel.self)

        }
}
