//
//  EncountView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct EncountBaseView: View {
    var body: some View {
        VStack(spacing: 20) {
                CircleImage()
                UserProfileCard()
                    .scaleEffect(0.9)
        }
        .padding(.top, 20)
        .frame( maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)

    }
}

#Preview {
    EncountBaseView()
}
