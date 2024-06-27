import SwiftUI

class RouterViewModel: ObservableObject {
    @Published var currentScreen: Router = .logIn
    @Published var userProfile: UserProfileModel?
    
    func navigateToMain() {
        currentScreen = .tabView
    }
}
