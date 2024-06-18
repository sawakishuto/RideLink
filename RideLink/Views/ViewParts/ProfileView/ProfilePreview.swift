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
    @Binding var inputImage: UIImage?
    var userImage: Data?
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
                        .offset(x: -75, y: -75)

                    if let userImage = userImage {
                        Image(uiImage: UIImage(data: userImage)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.trailing, 20)
            
            VStack(alignment: .leading) {
                Text(userName)
                    .font(.headline)
                
                Spacer().frame(height: 10)
                
                HStack {
                    Image("BikeIcon")
                        .resizable()
                        .frame(width: 35, height: 21)
                    
                    Text(bikeName)
                        .font(.subheadline)
                }
                Spacer().frame(height: 10)
                Text(touringComment ?? "")
                    .font(.caption)
            }
            Spacer()
        }
        .padding([.top, .leading, .trailing])
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 3)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
}
