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
    let encounterImage: String
    var body: some View {
        Map {
            Marker("ここでですれ違いました！🏍️", image: encounterImage, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
}

#Preview {
    EncountMap(latitude: 35.0, longitude: 36.0, encounterImage: "")
}
