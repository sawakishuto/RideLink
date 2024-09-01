
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

    static let shared =  APIClient()

    private let baseUrl = "https://4237-106-146-90-128.ngrok-free.app"
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
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        let headers: HTTPHeaders = [
                            "Authorization": token,
                            "Accept": "application/json"
                        ]
                        print("リクエストを送ります")
                        let request = AF.request(url, method: .get, parameters: params, headers: headers)
                        request.response { response in
                            guard let statusCode = response.response?.statusCode else {
                                print(response.response)
                                return
                            }
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
                            case 200:
                                print("成功しました！")
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
                                print(statusCode)
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
                            "Authorization": token,
                            "Accept": "application/json"
                        ]
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        print("リクエストを送ります")
                        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                            .responseDecodable(of: T.self){ response in
                                guard let statusCode = response.response?.statusCode else {return}

                                do {
                                    if statusCode <= 300 {
                                        guard let data = response.data else {return}
                                        print("デコードします")
                                        print(response.response?.headers.dictionary)
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
                                case 200:
                                    print("成功しました！")
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
                                    print(statusCode)
                                    promise(.failure(APIError.unknown))
                                }
                            }
                    }
                    .store(in: &self.cancellables)

            }
        }
        .eraseToAnyPublisher()
    }

    func putData<T: Codable>(endPoint: paths.RawValue,  params: Parameters, type: T.Type) -> AnyPublisher<T, Error> {
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
                            "Authorization": token,
                            "Accept": "application/json"
                        ]
                        let path = endPoint
                        let url = self.baseUrl.appending(path)
                        print("リクエストを送ります")
                        let request = AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers)
                            .responseDecodable(of: T.self){ response in
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
                                case 200:
                                    print("成功しました！")
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
                                    print(statusCode)
                                    promise(.failure(APIError.unknown))
                                }
                            }
                    }
                    .store(in: &self.cancellables)

            }
        }
        .eraseToAnyPublisher()
    }




    func postDeviceToken(endPoint: String, params: Parameters) {
        self.getUserToken()
            .sink { completion in
                switch completion {
                case .finished:
                    print("トークン取得完了")
                case .failure(let error):
                    print("トークン取得失敗: \(error)")
                }
            } receiveValue: { token in
                print("トークンを使ってヘッダーを作ります")
                let headers: HTTPHeaders = [
                    "Authorization": "\(token)",
                    "Accept": "application/json"
                ]
                let path = endPoint
                let url = self.baseUrl.appending(path)
                print("Postリクエストを送ります: \(url)")
                print("デバイストークンを送信します: \(params)")

                AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                    .validate(statusCode: 200..<300)
                    .response { response in
                        switch response.result {
                        case .success:
                            print("リクエスト成功: \(response)")
                        case .failure(let error):
                            print("リクエスト失敗: \(error)")
                            print(response.debugDescription)
                        }
                    }
            }
            .store(in: &self.cancellables)
    }
    // 差分があるときにデータを更新するメソッド（プロフィール欄とか, コメントとか, 位置情報とか？）
    func patchData(endPoint: paths.RawValue,  params: Parameters, token: String) {
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"

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

    func postLocationInfo(endPoint: paths.RawValue, locationInfo: [[String: Any]], completion: @escaping(Result<Bool, Never>) -> Void) {
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
                    "Authorization": token,
                    "Accept": "application/json"
                ]
                let path = endPoint
                let url = self.baseUrl.appending(path)
                var request =  URLRequest(url: URL(string: url)!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.headers = headers
                print("リクエストを送ります")
                do {
                    print(locationInfo)
                    request.httpBody = try JSONSerialization.data(withJSONObject: locationInfo, options: [])
                    if let jsonString = String(data: request.httpBody!, encoding: .utf8) {
                         print("Encoded JSON Data: \(jsonString)")
                     }
                } catch {
                    print("Error encoding parameters: \(error)")
                    return
                }
                AF.request(request).responseJSON { response in
                    print(response)
                    switch response.result {
                    case .success(let data):
                        completion(.success(true))
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        completion(.success(false))
                    }
                }
            }
            .store(in: &cancellables)

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
