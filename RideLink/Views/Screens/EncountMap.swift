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
    var body: some View {
        if #available(iOS 17.0, *) {
            Map {
                Marker(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                    VStack {
                        Image(systemName: "hand.raised.brakesignal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .cornerRadius(90)
                        Text("ここでですれ違いました！🏍️")
                            .font(.caption)
                    }
                }
            }
        } else {
           
            // Fallback on earlier versions
        }
    }
}

//#Preview {
//    EncountMap(latitude: 35.0, longitude: 36.0)
//}
