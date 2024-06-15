//
//  SignupView.swift
//  RideLink
//
//  Created by 拓実 on 2024/05/20.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var vehicleType = ""
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.horizontal)
            ZStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 150, height: 150)
                        .overlay(
                            Image(systemName: "camera")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        )
                }
            }
            .onTapGesture {
                isShowingImagePicker = true
            }
            .padding(.top, 0)
            
            // Text fields
            VStack(alignment: .leading, spacing: 10) {
                Text("メールアドレス")
                    .font(.headline)
                    .padding(.leading)
                TextField("", text: $email)
                    .textFieldStyle(.withCancel(text: $email))
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .textContentType(.emailAddress)
                Text("パスワード")
                    .font(.headline)
                    .padding(.leading)
                SecureField("", text: $password)
                    .textFieldStyle(.withCancel(text: $password))
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .textContentType(.password)
                Text("ユーザーネーム")
                    .font(.headline)
                    .padding(.leading)
                TextField("", text: $username)
                    .textFieldStyle(.withCancel(text: $username))
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .textContentType(.username)
                Text("車種")
                    .font(.headline)
                    .padding(.leading)
                TextField("", text: $vehicleType)
                    .textFieldStyle(.withCancel(text: $vehicleType))
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            //TODO: 新規登録を実行する
            AppButtonView(title: "新規登録", color: .green) {}.padding(.top, 20)
            Button(action: {}) {
                Text("ログインはこちら")
                    .foregroundColor(.blue)
                    .padding(.top, 10)
            }
            
            Spacer()
        }
        .sheet(isPresented: $isShowingImagePicker, content: {
            ImagePicker(image: $selectedImage)
        })
        .padding()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                let alert = UIAlertController(title: "確認", message: "本当にプロフィール画像を変更しますか？", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "はい", style: .default, handler: { _ in
                    self.parent.image = uiImage
                    self.parent.presentationMode.wrappedValue.dismiss()
                }))
                alert.addAction(UIAlertAction(title: "いいえ", style: .cancel, handler: { _ in
                    self.parent.presentationMode.wrappedValue.dismiss()
                }))
                picker.present(alert, animated: true)
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
