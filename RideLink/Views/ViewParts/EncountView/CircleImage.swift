//
//  CircleImage.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct CircleImage: View {
    let ImageURL: String

    var body: some View {
        AsyncImage(url: URL(string: ImageURL)!) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .cornerRadius(500)
                .shadow(color: .gray, radius: 4, x: 2, y: 5)
        } placeholder: {
            ProgressView()
                .frame(width: 250)
                .cornerRadius(500)
                .shadow(color: .gray, radius: 4, x: 2, y: 5)
        }
    }
}

#Preview {
    CircleImage(ImageURL: "https://www.irasutoya.com/2013/05/blog-post_7246.html")
}
