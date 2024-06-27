//
//  CommentEditor.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/28.
//

import SwiftUI

struct CustomCommentTextField: View {
    let placeholder: String
    @Binding var text: String
    var commit: ()->() = { }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image("pen")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("\(placeholder)")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 40)
            
            textField
            Spacer().frame(height: 20)
        }
    }
}

extension  CustomCommentTextField {
    var textField: some View {
        ZStack {
            TextField("\(placeholder)を入力してください", text: $text)
                .padding()
                .frame(width: 350)
        }
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 0.5))
    }
}
