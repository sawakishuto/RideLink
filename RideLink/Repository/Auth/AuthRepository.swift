//
//  AuthRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import FirebaseAuth
import Combine


final class AuthRepository: AuthRepositoryProtocol {
    private let auth = Auth.auth()
    func signIn(mailAdress: String, password: String) -> AnyPublisher<UserProfileModel, Error> {
        <#code#>
    }

    func signUp(mailAdress: String, password: String, user: UserProfileModel) {
        <#code#>
    }

    func getUserToken() -> Future <String, Error> {
        return Future { promise in
            guard let user = Auth.auth().currentUser else {
                let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is signed in"])
                promise(.failure(error))
                return
            }

            user.getIDToken { token, error in
                if let error = error {
                    promise(.failure(error))
                } else if let token = token {
                    promise(.success(token))
                } else {
                    let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get ID token"])
                    promise(.failure(error))
                }
            }
        }
    }


}
