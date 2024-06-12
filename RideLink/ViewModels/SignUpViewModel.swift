//
//  SignInViewModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/23.
//

import Foundation
import Combine

final class SignInViewModel: ObservableObject {
    private let authRepository: AuthRepository
    private var cancellables = Set<AnyCancellable>()

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func signUp(mailAdress: String, password: String) {
        authRepository.signUp(mailAdress: mailAdress, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    return
                case .finished:
                    break
                }

            } receiveValue: { uid in
                // getUserData(uid: uid)
                print(uid)
            }
            .store(in: &cancellables)

    }

}
