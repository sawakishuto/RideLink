import SwiftUI

class RouterViewModel: ObservableObject {
    @Published var currentScreen: Router = .logIn
    @Published var userProfile: UserProfileModel?
    private var deviceToken: String = ""
    init() {
        NotificationCenter.default.addObserver(forName:  Notification.Name("RecieveNotification"), object: nil, queue: .main, using: {
            if let userInfo = $0.userInfo{
                if let value = userInfo["token"] as? String {
                    self.deviceToken = value
                }
            }
        })
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func navigateToMain() {
        currentScreen = .tabView
        handleNotification(deviceToken: deviceToken)

    }
    @objc private func handleNotification (deviceToken: String) {
        APIClient.shared.postDeviceToken(endPoint: paths.token.rawValue, params: ["device_token": "\(deviceToken)"])
    }
}
