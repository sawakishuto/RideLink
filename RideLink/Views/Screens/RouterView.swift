import SwiftUI

struct RouterView: View {
    @StateObject private var routerState = RouterViewModel()
    
    var body: some View {
        Group {
            switch routerState.currentScreen {
            case .logIn:
                LoginView()
            case .signUp:
                SignupView()
            case .tabView:
                TabViews()
            }
        }
        .environmentObject(routerState)
    }
}
