//
//  EncountMap.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/12.
//

import SwiftUI
import MapKit

struct EncountMap: View {
    let latitude: Double
    let longitude: Double
    let encounterImage: Data?
    var body: some View {
        Map {
            Marker(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                VStack {
                    if let encounterImage = encounterImage {
                        Image(uiImage: UIImage(data: encounterImage)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .cornerRadius(90)
                    } else {
                        Image(systemName: "music.note")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .cornerRadius(90)
                    }
                    Text("ここでですれ違いました！🏍️")
                        .font(.caption)

                }
            }
        }
    }
}

#Preview {
    EncountMap(latitude: 35.0, longitude: 36.0, encounterImage: nil)
}
