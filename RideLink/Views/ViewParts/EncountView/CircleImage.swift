//
//  CircleImage.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct CircleImage: View {
    let ImageData: Data?

    var body: some View {
        if let ImageData = ImageData {
            Image(uiImage: UIImage(data: ImageData)!)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .cornerRadius(500)
                .shadow(color: .gray, radius: 4, x: 2, y: 5)
        } else {
            ProgressView()
                .frame(width: 250)
                .cornerRadius(500)
                .shadow(color: .gray, radius: 4, x: 2, y: 5)
        }
    }
}

#Preview {
    CircleImage(ImageData: nil)
}
