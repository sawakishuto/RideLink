//
//  ProfileView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI

//一旦前回作成したモデルの形式で残してる
class ProfileData: ObservableObject {
    @Published var username = "Kabu"
    @Published var bikename =  "YZF-R15"
    @Published var comment = "アプリ作成中"
}


struct ProfileView: View {
    @ObservedObject var profileData: ProfileData
    @State var tempUsername: String = ""
    @State var tempBikename: String = ""
    @State var tempComment: String = ""

    @State private var showingActionSheet = false
    
    var body: some View {
        VStack {
            ProfilePreView(profileData: profileData)
            Spacer().frame(height: 30)
            ProfileEditor(editSubject: $tempUsername, text: "ユーザーネーム")
            ProfileEditor(editSubject: $tempBikename, text: "バイク名")
            ProfileEditor(editSubject: $tempComment, text: "コメント")
            Spacer().frame(height: 60)
            Button(action: {
                self.showingActionSheet = true
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
                        self.profileData.username = self.tempUsername
                        self.profileData.bikename = self.tempBikename
                        self.profileData.comment = self.tempComment
                    },
                    .cancel()
                ])
            }
            Spacer()
        }.onAppear {
            tempUsername = profileData.username
            tempBikename = profileData.bikename
            tempComment = profileData.comment
        }
    }
}




#Preview {
    ProfileView(profileData: ProfileData())
}
