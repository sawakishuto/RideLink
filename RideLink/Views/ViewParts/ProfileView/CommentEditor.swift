//
//  CommentEditor.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/28.
//

import SwiftUI

enum inputType: String {
    case name = "ユーザー名"
    case bike = "バイク名"
    case comment = "一言コメント"
}

struct CustomCommentTextField: View {
    let placeholder: String
    let inputType: inputType
    @Binding var text: String
    var commit: ()->() = { }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image("pen")
                    .resizable()
                    .frame(width: 10, height: 10)
                Text(inputType.rawValue)
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
            TextField("\(placeholder)", text: $text)
                .padding()
                .frame(width: 350)
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
    }
}
