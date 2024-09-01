//
//  UserProfileCard.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import SwiftUI

struct UserProfileCard: View {
    let userName: String
    let bikeName: String
    let destinationName: String
    let comment: String
    let encountLatitude: Double
    let encountLongitude: Double
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 100){
                Text(userName)
                    .font(.system(size: 35))
                    .fontWeight(.black)
                
                NavigationLink {
                    EncountMap(latitude: encountLatitude, longitude: encountLongitude)
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 55, alignment: .center)
                            .foregroundStyle(.green)
                            .shadow(color: .gray, radius: 4, x: 5, y: 2)
                        
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                }
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
                    
                    Text(bikeName)
                        .font(.system(size: 20))
                        .foregroundStyle( Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1))
                    
                    Text(destinationName)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                }
            }
            Text(comment)
                .lineLimit(3)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 15)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 4, x: 2, y: 5)
    }
}
