//
//  ToastView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/26.
//

import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(width: 300, height: 10)
            .padding(15)
    }
}

