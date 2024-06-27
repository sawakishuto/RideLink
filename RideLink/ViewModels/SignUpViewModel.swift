import Combine
import Foundation
import UIKit

final class SignupViewModel: ObservableObject {
    private let authRepository = AuthRepository()
    private let userRepository = UserRepository()
    private var imageData: Data?
    private  var cancellables: Set<AnyCancellable> = []
    @Published var userProfile: UserProfileModel? = nil
    
    
    func signup(mailAdress: String, password: String, user: UserProfileModel) {
        authRepository.signUp(mailAdress: mailAdress, password: password)
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .finished:
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            } receiveValue: { response in
                //TODO: uiimageをdataに変更
                print("💎")
                self.userRepository.postUserData(userData: user)
                    .sink { response in
                        switch response {
                        case .finished:
                            print("終わり")
                            return
                        case .failure(let error):
                            print(#function)
                            print("でエラ-")
                        }
                    } receiveValue: { user in
                        self.userProfile = user
                    }

                print("💎2")
            }
            .store(in: &self.cancellables)
    }
    
    func convertImageToData(image: UIImage) -> Data? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            // JPEG形式への変換に失敗した場合はnilを返す
            print("🔥")
            return nil
        }
        return imageData
    }
}
