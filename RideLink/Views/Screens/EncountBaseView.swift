//
//  EncountView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct EncountBaseView: View {
    let encountImage: String
    let ImageURL: String
    let userName: String
    let bikeName: String
    let destinationName: String
    let comment: String
    let encountLatitude: Double
    let encountLogitude: Double
    var body: some View {
        VStack(spacing: 20) {
            CircleImage(ImageURL: ImageURL)
            UserProfileCard(
                encounterImage: encountImage,
                userName: userName,
                bikeName: bikeName,
                destinationName: destinationName,
                comment: comment,
                encountLatitude: encountLatitude,
                encountLongitude: encountLogitude
            )
                    .scaleEffect(0.9)
        }
        .padding(.top, 20)
        .frame( maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)

    }
}

#Preview {
    EncountBaseView(encountImage: "", ImageURL: "", userName: "", bikeName: "", destinationName: "", comment: "", encountLatitude: 0.0, encountLogitude: 0.0)
}
