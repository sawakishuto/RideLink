//
//  TextFieldView.swift
//  RideLink
//
//  Created by 拓実 on 2024/05/09.
//

import SwiftUI

struct AppTextFieldView: TextFieldStyle {
    @FocusState private var isFocused
    
    @Binding var text: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(spacing: 8) {
            configuration
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color.secondary.opacity(0.3), in: Capsule())
                .overlay(
                    HStack {
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.trailing, 12)
                        }
                    }
                )
        }
    }
}

extension TextFieldStyle where Self == AppTextFieldView {
    static func withCancel(text: Binding<String>) -> AppTextFieldView {
        .init(text: text)
    }
}
