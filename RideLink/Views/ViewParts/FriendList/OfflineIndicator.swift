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
                .frame(width: 30, height: 30)
                .padding(.leading, -3)
            Text("オフライン")
                .font(.system(size: 13))
        }
        .frame(width: 100, height: 5)
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
