//
//  LoginView.swift
//  RideLink
//
//  Created by 拓実 on 2024/05/09.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var routerState: RouterViewModel
    @State private var emailAddress = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                VStack(alignment: .leading, spacing: 16) {
                Text("メールアドレス")
                    .font(.headline)
                TextField("", text: $emailAddress)
                    .textFieldStyle(AppTextFieldView.withCancel(text: $emailAddress))
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                Text("パスワード")
                    .font(.headline)
                SecureField("", text: $password)
                    .textFieldStyle(AppTextFieldView.withCancel(text: $password))
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
            AppButtonView(title: "ログイン", color: .green) {
                self.viewModel.signin(
                    mailAdress: emailAddress,
                    password: password
                )
            }.padding(.top, 20)
            Button(action: {
                routerState.currentScreen = .signUp
            }) {
                Text("初めての方はこちら")
                    .foregroundColor(.blue)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .padding()
        .onReceive(viewModel.$isLoginSuccess) { state in
            if viewModel.isLoginSuccess {
                routerState.navigateToMain()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
