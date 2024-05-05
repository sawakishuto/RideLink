//
//  UserProfileCard.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct UserProfileCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 100){
                Text("澤木柊斗")
                    .font(.system(size: 35))
                    .fontWeight(.black)

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        Circle()
                            .frame(width: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.green)
                            .shadow(color: .gray, radius: 4, x: 5, y: 2)

                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                })
            }
            HStack(alignment: .center , spacing: 30) {

                VStack(alignment: .center, spacing: 10) {
                    Image("BikeIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)

                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)


                }
                VStack(alignment: .leading, spacing: 10) {

                    Text("YZF R-15")
                        .font(.system(size: 20))
                        .foregroundStyle( Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1))

                    Text("千里浜ドライブウェイ")
                        .fontWeight(.bold)
                        .foregroundStyle(.green)

                }
            }
            Text("今日ツーリングデビュー！チピチピチャパチるびるびらんらんらんんんんんんんんんんんんんんんんん今日ツーリングデビュー！チピチピチャパチるびるびらんらんらんんんんんんんんんんんんんんんんん今日ツーリングデビュー！チピチピチャパチるびるびらんらんらんんんんんんんんんんんんんんんんん")
                .lineLimit(3)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 15)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 4, x: 2, y: 5)
    }
}

#Preview {
    UserProfileCard()
}
