//
//  ProfileEditor.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
        .padding()
        .frame(width: 350)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 0.5))
    }
}

struct ProfileEditor: View {
    @Binding var name: String
    var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image("pen")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(text)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 40)
            CustomTextField(placeholder: Text("名前を入力してください"), text: $name)
            Spacer().frame(height: 20)
        }
    }
}
