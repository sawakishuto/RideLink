
//
//  APIClient.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/14.
//

import Foundation
import Combine
import Alamofire
import FirebaseAuth


final class APIClient {

    static let shared = APIClient()

    private let baseUrl = "http://localhost:8080"
    private var cancellables: Set<AnyCancellable> = []

    // データを取得するメソッド  ジェネリクスで指定してるから柔軟に使えるはずだよ
    func fetchData<T: Decodable>(endPoint: paths.RawValue, params: Parameters?, type: T.Type) -> AnyPublisher<T, Error> {
        return Deferred {
            Future { promise in
                print(#function)
                self.getUserToken()
                    .sink { response in
                        switch response {
                        case .failure(let error):
                            print("🎉トークン取得できない")
                            promise(.failure(error))
                        case .finished:
                            print("終了")
                            return
                        }
                    } receiveValue: { token in
                        print("🎉トークン取得できた")
                        print(token)
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        let headers: HTTPHeaders = [
                            "Authorization": token
                        ]
                        let request = AF.request(url, method: .get, parameters: params, headers: headers)
                            .validate(contentType: ["application/json"])
                        request.response { response in
                            guard let statusCode = response.response?.statusCode else {return}

                            do {
                                if statusCode <= 300 {
                                    guard let data = response.data else {return}
                                    print("デコードします")
                                    let decode = JSONDecoder()
                                    let value = try decode.decode(T.self, from: data)
                                    print("デコード成功")
                                    promise(.success(value))
                                    
                                }
                            } catch {
                                print("デコードに失敗しました😢")
                                print(response.debugDescription)
                                promise(.failure(APIError.decodeError))
                            }
                            switch statusCode {
                            case 400:
                                print(response.description)
                                promise(.failure(APIError.forbidden))
                            case 401:
                                print(response.description)
                                print("認証失敗😭")
                                promise(.failure(APIError.auth))
                                
                            case 403:
                                print(response.description)
                                print("アクセス権がありません😭")
                                promise(.failure(APIError.forbidden))
                            case 404:
                                print(response.description)
                                print("URLがあかんよ😭")
                                promise(.failure(APIError.invalidUrl))
                                
                            default:
                                print("不明なエラー")
                                promise(.failure(APIError.unknown))
                            }
                        }
                    }
                    .store(in: &self.cancellables)
            }
        }
        .eraseToAnyPublisher()
    }
    // 新規でデータを保存するメソッド
    func postData<T: Codable>(endPoint: paths.RawValue,  params: Parameters, type: T.Type) -> AnyPublisher<T, Error> {
        return Deferred {
           Future { promise in
               self.getUserToken()
                    .sink { response in
                        switch response {
                        case .finished:
                            print("終了しました")
                            break
                        case .failure(let error):
                            print("トークン失敗")
                            return promise(.failure(error))
                        }
                    } receiveValue: { token in
                        print("トークンを使ってヘッダーを作ります")
                        let headers: HTTPHeaders = [
                            "Authorization": token
                        ]
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        print("リクエストを送ります")
                        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                            .responseDecodable(of: T.self){ response in
                                if let response = response.response { print("レスポンスがnilです")
                                    return
                                }
                                print("結果をデコードします")
                                switch response.result {
                                case .success(let data):
                                    print("リクエスト成功\(data)")
                                    return promise(.success(data as! T))
                                case .failure(let error):
                                    print("リクエスト失敗\(error)")
                                    return
                                }
                            }
                    }
                    .store(in: &self.cancellables)

            }
        }
        .eraseToAnyPublisher()
    }


    func postDeviceToken(endPoint: paths.RawValue,  params: Parameters) {
               self.getUserToken()
                    .sink { response in
                        switch response {
                        case .finished:
                            print("終了しました")
                            break
                        case .failure(let error):
                            print("トークン失敗")
                            return
                        }
                    } receiveValue: { token in
                        print("トークンを使ってヘッダーを作ります")
                        let headers: HTTPHeaders = [
                            "Authorization": token
                        ]
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        print("リクエストを送ります")
                        print("デバイストークンを送信します")
                        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                            .response
                        print("\(token)")
                    }
                    .store(in: &self.cancellables)
    }

    // 差分があるときにデータを更新するメソッド（プロフィール欄とか, コメントとか, 位置情報とか？）
    func patchData(endPoint: paths.RawValue,  params: Parameters, token: String) {
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        let path = endPoint
        let url = baseUrl.appending(path)

        let request = AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let response = response.response { return }

                switch response.result {
                case .success(let data):
                    print("リクエスト成功\(data)")
                case .failure(let error):
                    print("リクエスト失敗\(error)")
                }
            }
    }

    // 新規登録で写真を保存する時に使う
    func postImageData(id: String, imageData: Data) {
        let url = baseUrl

        AF.upload(multipartFormData: { mfData in
            mfData.append(imageData,withName: "\(id)ProfileImageData", fileName: "\(id)ProfileImage.jpg", mimeType: "image/jpeg")
        }, to: url)
        .responseJSON { response in
            if let response = response.response {return}

            switch response.result {
            case .success(let data):
                print("リクエスト成功\(data)")
            case .failure(let error):
                print("リクエスト失敗\(error)")
            }
        }
    }

    // 写真を変更する時に使うメソッド
    func patchImageData(id: String, imageData: Data) {
        let url = baseUrl
        AF.upload(multipartFormData: { mfData in
            mfData.append(imageData,withName: "\(id)ProfileImageData", fileName: "\(id)ProfileImage.jpg", mimeType: "image/jpeg")
        }, to: url, method: .patch)
        .responseJSON { response in
            if let response = response.response {return}

            switch response.result {
            case .success(let data):
                print("リクエスト成功\(data)")
            case .failure(let error):
                print("リクエスト失敗\(error)")
            }
        }
    }
  
    func getUserToken() -> Future <String, Error> {
        return Future { promise in
            guard let user = Auth.auth().currentUser else {
                print("🎉トークン取得してます")
                let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is signed in"])
                return promise(.failure(error))
                return
            }
            user.getIDToken { token, error in
                if let error = error {
                    print("🎉トークン取得失敗")
                    promise(.failure(error))
                } else if let token = token {
                    print("🎉トークン取得成功")
                    print(token)
                    return promise(.success(token))
                } else {
                    let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get ID token"])
                    return promise(.failure(error))
                }
            }
        }
    }





}
