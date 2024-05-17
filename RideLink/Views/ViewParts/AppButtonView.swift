//
//  AppButtonView.swift
//  RideLink
//
//  Created by 拓実 on 2024/05/09.
//

// CustomButton.swift

import SwiftUI

struct AppButtonView: View {
    var title: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
                .padding()
                .frame(width: 150, height: 50)
                .foregroundColor(.black)
                .background(color)
                .cornerRadius(25)
        }
        .padding(.horizontal)
    }
}
