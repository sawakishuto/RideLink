//
//  ProfilePreview.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/07.
//

import SwiftUI

struct ProfilePreView: View {
    @EnvironmentObject var profileData: ProfileData

    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                Button(action: {
                }) {
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray)
                        .offset(x: -75, y: -75)
                }
                Image("kabuBike")//Todo修正
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)
            VStack(alignment: .leading) {
                Text(profileData.username)
                    .font(.headline)
                Spacer().frame(height: 10)
                HStack {
                    Image("bikeicon")//Todo修正
                        .resizable()
                        .frame(width: 35, height: 21)
                    Text(profileData.bikename)
                        .font(.subheadline)
                }
                Spacer().frame(height: 10)
                Text(profileData.comment)
                    .font(.caption)
            }
            Spacer()
        }
        .padding([.top, .leading, .trailing])
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 3)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
}
