//
//  UserCard.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

struct UserCard: View {
    let userIcon: Data?
    let userName: String
    let bikeName: String
    let comment: String

    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                if let profileIcon = userIcon {
                    Image(uiImage: UIImage(data: userIcon!)!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                        .padding(.leading, 5)
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                        .padding(.leading, 5)
                }
                VStack {
                    
                    Text(userName)
                        .bold()
                        .font(.system(size: 20))
                    
                    HStack {
                        
                        Image("mainBike")
                            .resizable()
                            .frame(width: 35, height: 21)
                            .padding(.leading, 25)
                            .padding(.trailing, -5)
                        
                        Text(bikeName)
                            .font(.system(size: 20))
                        
                    }
                    .padding(.bottom, 5)
                    
                    Text(comment)
                        .font(.system(size: 20))
                    
                }
                Spacer()
            }
            .padding()
            .frame(height: 120)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        .padding(.horizontal)
        }
        .foregroundColor(.black)
    }
}
