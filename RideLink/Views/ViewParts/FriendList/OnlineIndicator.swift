//
//  OnlineIndicator.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

struct OnlineIndicator: View {
    var body: some View {
        HStack {
                Image("mainBike")
                    .resizable()
                    .frame(width: 30, height: 25)
                Text("オンライン")
                    .font(.system(size: 13))
            }
            .frame(width: 100, height: 5)
            .padding()
            .background(Color(red: 5/255, green: 254/255, blue: 90/255))
            .foregroundColor(.black)
            .cornerRadius(40)
        }
    }

//#Preview {
//    OnlineIndicator()
//}
