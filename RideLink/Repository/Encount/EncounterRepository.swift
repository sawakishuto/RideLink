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
    private var cancellables = Set<AnyCancellable>()

    func sendFriendReqest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    func postTouringEnd() {
        apiClient.fetchData(endPoint: paths.touringEnd.rawValue, params: nil, type: Never.self)
            .sink {
                switch $0 {
                case .finished:
                    return
                case .failure(let error):
                    return
                }
            } receiveValue: {
                print($0)
                return
            }
            .store(in: &self.cancellables)

    }



    //    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error> {
    //        let subject = CurrentValueSubject<FriendInfoModel, Error>(FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil)))
    //        subject.send((FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil))))
    //        return subject.eraseToAnyPublisher()
    //    }

    func getEncountInfo() -> AnyPublisher<[EncountInfoModel], Error> {
        return Deferred {
            Future { promise in
                self.apiClient.fetchData(endPoint: paths.encount.rawValue, params: nil, type: [EncountInfoModel].self)
                    .receive(on: DispatchQueue.global(qos: .background))
                    .sink { response in
                        switch response {
                        case.failure(let error):
                            promise(.failure(error))
                        case .finished:
                            return
                        }
                    } receiveValue: { result in
                        promise(.success(result))
                    }
                    .store(in: &self.cancellables)
            }
        }
        .eraseToAnyPublisher()
    }

    func acceptFriendRequest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    func formatDateToISO8601(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }

    func postUserLocation(userLocInfo: [LocatinInfo]) -> AnyPublisher<Bool, Error> {
        print(#function)
        print(userLocInfo)
        var locationInfo: [[String: Any]] = []
        
        print("\(Date())")

        for info in userLocInfo {
            print("時間を表示します")
            //            print(info.createAt)
            // Dateオブジェクトを文字列に変換
            locationInfo.append([
                "latitude": info.latitude,
                "longitude": info.longitude,
                "stayed_at": info.createAt
            ])
        }
        return Deferred {
            Future { promise in
                self.apiClient.postLocationInfo(endPoint: paths.location.rawValue, locationInfo: locationInfo) { result in
                    switch result {
                    case .success(true):
                        print("locationを更新しました")
                    case .failure:
                        print("locationの更新に失敗しました。")
                    case .success(false):
                        print("")
                        return
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    func postTouringCondition(touringCondition: TouringInfoModel) {
        print(#function)
        var param: Parameters = [
            "destination": "\(String(describing: touringCondition.destinationName))",
            "touring_comment": "\(String(describing: touringCondition.touringComment))"
        ]
        print("\(param)")
        apiClient.postData(endPoint: paths.touringStart.rawValue, params: param, type: TouringInfoModel.self)
            .sink { result in
                switch result {
                case .finished:
                    return
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { info in
                print(info)
            }


    }
}
