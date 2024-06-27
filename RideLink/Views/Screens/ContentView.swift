import SwiftUI
import FirebaseCore
import FirebaseAuth
import Combine

struct ContentView: View {
    @State private var notificationPayload: [AnyHashable: Any]?
    @ObservedObject var vm = ContentViewModel()
    var cancellables = Set<AnyCancellable>()
    let repository = UserRepository()

    var body: some View {
        GeometryReader { geometory in

            ZStack(alignment: .center){

                if vm.isRecieveNotification {
                    bannerNotification(encountCount: vm.count, isRecieveNotification: $vm.isRecieveNotification)
                        .position(
                            x: geometory.size.width * 0.56,
                            y: geometory.size.height * 0.6
                        )
                        .zIndex(100)
                }

                MapView()
            }
            .ignoresSafeArea()
        }
        .onAppear {
            signIn()
        }
    }

     func signIn() {
        let auth = Auth.auth()
        auth.signIn(withEmail: "shuto@g.com", password: "111111") { result, error in
            print(result)
        }
    }
    }


    #Preview {
        ContentView()
    }
