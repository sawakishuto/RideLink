//
//  TouringButton.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/06.
//

import SwiftUI

struct TouringButton: View {
    @State private var showingTouringSheet = false
    @State private var destination = ""
    @State private var touringComment = ""

    var body: some View {
        VStack {
            Button(action: {
                self.showingTouringSheet = true
            }) {
                VStack {
                    Image("bikeicon2")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, -10)
                    Text("ツーリングを開始する")
                        .padding(.trailing, 10)
                    Spacer()
                }
                .frame(width: 320, height: 40)
                .padding()
                .background(Color(red: 5/255, green: 254/255, blue: 90/255))
                .foregroundColor(.black)
                .cornerRadius(40)
            }
        }
        .padding(.vertical, 20)
    }
}
