import Foundation
import Alamofire
import FirebaseAuth
import Combine


final class AuthRepository: AuthRepositoryProtocol {
    private let auth = Auth.auth()
    private let apiClient = APIClient.shared
    
    func signIn(mailAdress: String, password: String)  -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                self.auth.signIn(withEmail:mailAdress, password: password) { response,
                    error in
                    if let response = response {
                        promise(.success(true))
                    } else if let error = error {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp(mailAdress: String, password: String) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                self.auth.createUser(withEmail: mailAdress, password: password) { response, error in
                    if let response = response {
                        promise(.success(true))
                    } else if let error = error {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func uploadProfileImage(id: String, imageData: Data) {
        apiClient.postImageData(id: id, imageData: imageData)
    }
}
