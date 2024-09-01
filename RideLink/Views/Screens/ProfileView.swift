//
//  ProfileView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @State private var showingActionSheet = false
    @State private var showingToast = false
    @State private var editedUserName: String = ""
    @State private var editedBikeName: String = ""
    @State private var editedComment: String = ""
    @State private var inputImage: UIImage?
    @State private var iconImage: Data? = nil
    @State private var isEdiging: Bool = false

    var body: some View {
        VStack {
            ProfilePreView(
                iconImage: $iconImage,
                inputImage: $inputImage,
                userName: vm.originalData.name ?? "",
                bikeName: vm.originalData.bike ?? "",
                touringComment: vm.originalData.profileComment
            )
            Spacer().frame(height: 30)
            CustomCommentTextField(placeholder: "watnow", inputType: .name,  text: $editedUserName)
            CustomCommentTextField(placeholder: "DS400", inputType: .bike, text: $editedBikeName)
            CustomCommentTextField(placeholder: "よろしくお願いします！", inputType: .comment, text: $editedComment)

            Spacer().frame(height: 30)
            if showingToast {
                ToastView(message:  "未記入の項目があります")
            }

            Spacer().frame(height: 30)

            Button(action: {
                showingActionSheet = true

            }) {
                Text("更新")
                    .fontWeight(.bold)
                    .frame(width: 80, height: 15)
                    .padding()
                    .background(isEdiging ? Color(red: 5/255, green: 254/255, blue: 90/255): .gray)
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(color: .gray, radius: 4, x: 3, y: 3)
            }
            .disabled(!isEdiging)
            Spacer()
        }
        .alert(isPresented: $showingActionSheet) {
            Alert(
                title: Text("変更を保存しますか？"),
                message: Text("この操作を取り消すことはできません。"),
                primaryButton: .default(Text("保存")) {
                    vm.save(userName: editedUserName, bikeName: editedBikeName, profileComment: editedComment) {
                        print("発火しました")
                        editedComment = ""
                        editedBikeName = ""
                        editedUserName = ""
                        vm.getUserProfile()
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            self.vm.getUserProfile()
        }
        .onChange(of: inputImage) { newImage in
            if let newImage = newImage {
                vm.loadImage(inputImage: newImage)
            }
        }
        .onChange(of: vm.originalData.iconImage) { newValue in
            self.iconImage = newValue
        }
        .onChange(of: editedUserName) { _ in checkCanSave() }
        .onChange(of: editedBikeName) { _ in checkCanSave() }
        .onChange(of: editedComment) { _ in checkCanSave() }
    }
    private func checkCanSave() {
        if self.editedComment != vm.originalData.profileComment ||  self.editedBikeName != vm.originalData.bike ||  self.editedUserName != vm.originalData.name {
            isEdiging = true
        }
    }
}
