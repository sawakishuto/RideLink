//
//  ProfilePreview.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/07.
//

import SwiftUI
import Alamofire

struct ProfilePreView: View {
    @State private var showingImagePicker = false
    @Binding var iconImage: Data?
    @Binding var inputImage: UIImage?
    var userImage: Data? = nil
    var userName: String
    var bikeName: String
    var touringComment: String?

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
                        .offset(x: -55, y: -65)

                    if let iconImage = iconImage {
                        Image(uiImage: UIImage(data: iconImage)!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.trailing, 20)
            
            HStack(alignment: .center) {
                Image("BikeIcon")
                    .resizable()
                    .frame(width: 35, height: 21)
                    .padding(.top, 7)

                VStack(alignment: .leading) {
                    Text(userName)
                        .font(.system(size: 23))
                        .fontWeight(.bold)

                    Spacer().frame(height: 10)

                        Text(bikeName)
                            .font(.subheadline)

                    Spacer().frame(height: 10)

                    Text(touringComment ?? "")
                        .font(.caption)
                }
            }

            Spacer()
        }
        .padding([.top, .leading, .trailing])
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }

        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .frame(height: 1)
            .shadow(color: .gray, radius: 5, x: 0, y: 1)

    }
}
