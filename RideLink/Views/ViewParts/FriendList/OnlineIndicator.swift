//
//  OnlineIndicator.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/07.
//

import SwiftUI

struct OnlineIndicator: View {
    var body: some View {
        HStack {
                Image("mainBike")
                    .resizable()
                    .frame(width: 35, height: 30)
                Text("オンライン")
            }
            .frame(width: 125, height: 10)
            .padding()
            .background(Color(red: 5/255, green: 254/255, blue: 90/255))
            .foregroundColor(.black)
            .cornerRadius(40)
        }
    }

#Preview {
    OnlineIndicator()
}
