//
//  TextFieldView.swift
//  RideLink
//
//  Created by 拓実 on 2024/04/24.
//

import SwiftUI

struct TextFieldView: TextFieldStyle {
    @FocusState private var isFocused
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(spacing: 8) {
            HStack(spacing: 8) {
                configuration
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(.secondary.opacity(0.3), in: Capsule())
        }
    }
}

extension TextFieldStyle where Self == TextFieldView {
    static var withCancel: TextFieldView {
        .init()
    }
}
