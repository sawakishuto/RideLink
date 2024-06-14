//
//  AuthRepositoryProtocol.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine
import FirebaseAuth

protocol AuthRepositoryProtocol: AnyObject {
//    signInが成功した時はRepositoryでそのままUserProfileを取得するメソッドを呼び出して取得したユーザー情報をViewModelで返す
//    ソウマと相談して、signinが成功したときに何を返すかでその後の処理は考えてみてほしい(例えば成功した時のレスポンスとして、ユーザー情報を返すのか、uidのみを返すのか)
//    signinに成功したらuidまたはUser情報をenvirnomentObject(すべてのViewからアクセスできるデータ)として設定してほしい
//    func signIn(mailAdress: String, password: String) -> AnyPublisher<UserProfileModel, Error>
//    signUpが成功した時はRepositoryでそのままUserProfileを取得するメソッドを呼び出して取得したユーザー情報をViewModelで返す
    func signUp(mailAdress: String, password: String, user: UserProfileModel)
//    追加でできれば
//    func deleteAccount()を調査して実装してみてほしい
}
