import Combine
import Foundation
import UIKit

final class LoginViewModel: ObservableObject {
    private let authRepository = AuthRepository()
    private let userRepository = UserRepository()
    private var imageData: Data?
    private  var cancellables: Set<AnyCancellable> = []
    @Published var userProfile: UserProfileModel? = nil
    @Published var isLoginSuccess: Bool = false

    
    func signin(mailAdress: String, password: String) {
        authRepository.signIn(mailAdress: mailAdress, password: password)
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .finished:
                    print("authRepository.signIn(mailAdress: mailAdress, password: password)")
                    self.isLoginSuccess = true
                    
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            } receiveValue: { response in
                //TODO: uiimageをdataに変更
                if response {
                    self.isLoginSuccess = true
                } else {
                    print("失敗じょ")
                    return
                }
            }
            .store(in: &self.cancellables)
    }
}
