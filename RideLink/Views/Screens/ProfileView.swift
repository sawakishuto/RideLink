//
//  ProfileView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI


//mock data
let today = Calendar.current.startOfDay(for: Date())



struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @State private var showingActionSheet = false
    @State private var showingToast = false
    @State private var editedUserName: String = ""
    @State private var editedBikeName: String = ""
    @State private var editedComment: String = ""
    
    var body: some View {
        VStack {
            
            ProfilePreView(
                userImage: vm.originalData.profileIcon,
                userName: vm.originalData.userName,
                bikeName: vm.originalData.bikeName,
                touringComment: vm.originalData.touringcomment
            )
            Spacer().frame(height: 30)
            CustomCommentTextField(placeholder: "ユーザー名",  text: $editedUserName)
            CustomCommentTextField(placeholder: "バイク名", text: $editedBikeName)
            CustomCommentTextField(placeholder: "ツーリングコメント", text: $editedComment)
            
            Spacer().frame(height: 30)
            if showingToast {
                ToastView(message:  "未記入の項目があります")
            }
            
            Spacer().frame(height: 30)
            
            Button(action: {
                let  result = vm.validationData(userName: editedUserName, bikeName: editedBikeName, userComment: editedComment)
                switch result {
                case .success(true):
                    showingActionSheet = true
                case .success(false):
                    showingToast = true
                case .failure(let error):
                    return
                }
            }) {
                
                Text("更新")
                    .frame(width: 80, height: 15)
                    .padding()
                    .background(Color(red: 5/255, green: 254/255, blue: 90/255))
                    .foregroundColor(.black)
                    .cornerRadius(40)
            }
            Spacer()
        }
        .alert(isPresented: $showingActionSheet) {
            Alert(
                title: Text("変更を保存しますか？"),
                message: Text("この操作を取り消すことはできません。"),
                primaryButton: .default(Text("保存")) {
                    vm.save(userName: editedUserName, bikeName: editedBikeName, userComment: editedComment)
                },
                secondaryButton: .cancel()
            )
        }
        .onChange(of: vm.canSave) { newValue in
            if newValue {
                self.showingToast = false
            }
        }
        .onAppear {
            self.editedComment = vm.originalData.touringcomment ?? ""
            self.editedBikeName = vm.originalData.bikeName ?? ""
            self.editedUserName = vm.originalData.userName ?? ""
        }
    }
}
