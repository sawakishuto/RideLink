//
//  OfflineIndicator.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/07.
//

import SwiftUI

struct OfflineIndicator: View {
    var body: some View {
        HStack {
            Image("subBike")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading, -3)
            Text("オフライン")
        }
        .frame(width: 125, height: 10)
        .padding()
        .background(Color(red: 217/255, green: 212/255, blue: 212/255))
        .foregroundColor(.black)
        .cornerRadius(40)
    }
}

#Preview {
    VStack {
        OnlineIndicator()
        OfflineIndicator()
    }
}
