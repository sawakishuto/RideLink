//
//  APIClient.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/14.
//

import Foundation
import Combine
import Alamofire

final class APIClient {

    static let shared = APIClient()
    // データを取得するメソッド  ジェネリクスで指定してるから柔軟に使えるはずだよ
    func fetchData<T: Decodable>(endPoint: paths.RawValue, params: Parameters, type: T.Type,headers: HTTPHeaders , completion: @escaping (T) -> Void) {

        let path = endPoint
        let url = baseUrl.appending(path)

        let request = AF.request(url, method: .get, parameters: params, headers: headers)
            .validate(contentType: ["application/json"])
        request.response { response in
            let statusCode = response.response!.statusCode

            do {
                if statusCode <= 300 {
                    guard let data = response.data else {return}

                    let decode = JSONDecoder()
                    let value = try decode.decode(T.self, from: data)
                    completion(value)
                }
            } catch {
                print("デコードに失敗しました😢")
                print(response.debugDescription)
            }
            switch statusCode {
            case 400:
                print(response.description)
            case 401:
                print(response.description)
                print("認証失敗😭")
            case 403:
                print(response.description)
                print("認証失敗()")
            case 404:
                print(response.description)
                print("URLがあかんよ😭")

            default:
                print("不明なエラー")
            }
        }
    }
    // 新規でデータを保存するメソッド
    func postData<T: Decodable>(endPoint: paths.RawValue,  params: Parameters, token: String, type: T.Type) {
        let headers: HTTPHeaders = [
            "Token": token
        ]
        let path = endPoint
        let url = baseUrl.appending(path)

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
