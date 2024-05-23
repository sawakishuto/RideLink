//
//  APIClient.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/14.
//

import Foundation
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
