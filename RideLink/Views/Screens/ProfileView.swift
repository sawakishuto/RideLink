//
//  ProfileView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm: ProfileViewModel
    @State private var showingActionSheet = false
    
    var body: some View {
        VStack {
            ProfilePreView()
            Spacer().frame(height: 30)
            ProfileEditor(editSubject: $vm.editData.username, text: "ユーザーネーム")
            ProfileEditor(editSubject: $vm.editData.bikename, text: "バイク名")
            ProfileEditor(editSubject: $vm.editData.comment, text: "コメント")
            Spacer().frame(height: 60)
            Button(action: {
                if vm.canSave {
                    self.showingActionSheet = true
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
                    },
                    .cancel()
                ])
            }
            Spacer()
        }
    }
}


#Preview {
    ProfileView()
}
