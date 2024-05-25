//
//  UserCard.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

struct UserCard: View {
    let userProfile: UserProfileModel

    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                Image(userProfile.profileIcon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                    .padding(.leading, 5)
                VStack {
                    
                    Text(userProfile.userName)
                        .bold()
                        .font(.system(size: 20))
                    
                    HStack {
                        
                        Image("mainBike")
                            .resizable()
                            .frame(width: 35, height: 21)
                            .padding(.leading, 25)
                            .padding(.trailing, -5)
                        
                        Text(userProfile.bikeName)
                            .font(.system(size: 20))
                        
                    }
                    .padding(.bottom, 5)
                    
                    Text(userProfile.touringcomment ?? "")
                        .font(.system(size: 20))
                    
                }
                Spacer()
            }
            .padding()
            .frame(height: 120)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        .padding(.horizontal)
        }
        .foregroundColor(.black)
    }
}
