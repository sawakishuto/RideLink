//
//  CircleImage.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("TestBikeImage")
            .resizable()
            .scaledToFit()
            .frame(width: 250)
            .cornerRadius(500)
            .shadow(color: .gray, radius: 4, x: 2, y: 5)
    }
}

#Preview {
    CircleImage()
}
