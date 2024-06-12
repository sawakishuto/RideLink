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
    let auth = Auth.auth()

    private let baseUrl = "http://localhost:8080"



    func getUserToken() -> AnyPublisher <String, Error> {
        return Deferred {
            Future { promise in
                print(#function)
                guard let user = Auth.auth().currentUser else {
                    let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is signed in"])
                    print("エラー")
                    promise(.failure(error))
                    return
                }

                user.getIDToken { token, error in
                    if let error = error {
                        print("エラー1")

                        promise(.failure(error))
                    } else if let token = token {
                        print("エラー2")

                        promise(.success(token))
                    } else {
                        print("エラー3")

                        let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get ID token"])
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }


    // データを取得するメソッド  ジェネリクスで指定してるから柔軟に使えるはずだよ
    func fetchData<T: Decodable>(endPoint: paths.RawValue, params: Parameters?, type: T.Type?) -> AnyPublisher<T, Error> {

        return Deferred {
            Future { promise in
                self.getUserToken()
                    .sink { response in
                        switch response {
                        case .finished:
                            return
                        case .failure(let error):
                            return
                        }
                    } receiveValue: { token in
                        let token = token

                let path = endPoint
                let url = self.baseUrl.appending(path)
                        let headers: HTTPHeaders = HTTPHeaders([HTTPHeader(name: "token", value: token)])

                let request = AF.request(url, method: .get, parameters: params, headers: headers)
                    .validate(contentType: ["application/json"])
                        request.response { response in
                            let statusCode = response.response!.statusCode

                            do {
                                if statusCode <= 300 {
                                    guard let data = response.data else {return}

                                    let decode = JSONDecoder()
                                    let value = try decode.decode(T.self, from: data)
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
            }
        }
        .eraseToAnyPublisher()
    }
    // 新規でデータを保存するメソッド
    func postData<T: Decodable>(endPoint: paths.RawValue,  params: Parameters, type: T.Type) {
        print(#function)
        getUserToken()
            .sink { response in
                switch response {
                case .finished:
                    print("終わりました")
                    return
                case .failure(let error):
                    print("エラー")
                    return
                }
            } receiveValue: { token in
                print(token)
                let token = token

                let headers: HTTPHeaders = [
                    "Token": token
                ]
                let path = endPoint
                let url = self.baseUrl.appending(path)
                print("ポストします")

                let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                    .responseDecodable(of: T.self){ response in
                        if let response = response.response { return }

                        switch response.result {
                        case .success(let data):
                            print("リクエスト成功\(data)")
                        case .failure(let error):
                            print("リクエスト失敗\(error)")
                        }
                    }
            }
    }

    // 差分があるときにデータを更新するメソッド（プロフィール欄とか, コメントとか, 位置情報とか？）
    func patchData(endPoint: paths.RawValue,  params: Parameters, token: String) {
        let headers: HTTPHeaders = [
            "Token": token
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
}
