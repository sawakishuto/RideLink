//
//  ProfilePreview.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/07.
//

import SwiftUI

struct ProfilePreView: View {
    @Binding var profileData: UserProfileModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        HStack {
            Button(action: {
                self.showingImagePicker = true
            }) {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray)
                        .offset(x: -75, y: -75)
                    Image(uiImage: inputImage ?? UIImage(named: profileData.profileIcon)!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
            }
            .padding(.trailing, 20)
            VStack(alignment: .leading) {
                Text(profileData.userName)
                    .font(.headline)
                Spacer().frame(height: 10)
                HStack {
                    Image("bikeicon")
                        .resizable()
                        .frame(width: 35, height: 21)
                    Text(profileData.bikeName)
                        .font(.subheadline)
                }
                Spacer().frame(height: 10)
                Text(profileData.touringcomment ?? "")
                    .font(.caption)
            }
            Spacer()
        }
        .padding([.top, .leading, .trailing])
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 3)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        // 画像をアップロードするためのAPIを呼び出したり、画像をローカルに保存したりするコードをここに書く
    }
}
