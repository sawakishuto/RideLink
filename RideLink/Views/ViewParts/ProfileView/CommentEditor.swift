//
//  CommentEditor.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/28.
//

import SwiftUI

struct CustomCommentTextField: View {
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

struct CommentEditor: View {
    @Binding var editSubject: String?
    
    var body: some View {
        VStack {
            HStack {
                Image("pen")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("コメント")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 40)
            CustomCommentTextField(placeholder: Text("コメントを入力してください"), text: Binding(
                get: { editSubject ?? "" },
                set: { newValue in editSubject = newValue.isEmpty ? nil : newValue }
            ))
            Spacer().frame(height: 20)
        }
    }
}
