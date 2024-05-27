//
//  ProfileView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI


//mock data
let today = Calendar.current.startOfDay(for: Date())

var profileData = UserProfileModel(
    userName: "kaka",
    bikeName: "yzf",
    profileIcon: "kabuBike",
    touringcomment: "hello",
    createAt: today
);

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel(originalData: profileData)
    @State private var showingActionSheet = false
    @State private var showingToast = false
    
    var body: some View {
        VStack {
            ProfilePreView(profileData: $vm.originalData)
            Spacer().frame(height: 30)
            ProfileEditor(editSubject: $vm.editData.username, text: "ユーザーネーム")
            ProfileEditor(editSubject: $vm.editData.bikename, text: "バイク名")
            CommentEditor(editSubject: $vm.editData.comment)
            Spacer().frame(height: 30)
            if showingToast {
                ToastView(message:  "未記入の項目があります")
            }
            Spacer().frame(height: 30)
            Button(action: {
                if vm.canSave {
                    self.showingActionSheet = true
                } else {
                    self.showingToast = true
                }
            }) {
                Text("更新")
                    .frame(width: 80, height: 15)
                    .padding()
                    .background(Color(red: 5/255, green: 254/255, blue: 90/255))
                    .foregroundColor(.black)
                    .cornerRadius(40)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("変更を保存しますか？"), buttons: [
                    .default(Text("保存")) {
                        vm.save()
                        self.showingActionSheet = false
                    },
                    .cancel()
                ])
            }
            Spacer()
        }
        .onChange(of: vm.canSave) { newValue in
            if newValue {
                self.showingToast = false
            }
        }
    }
}
