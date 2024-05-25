//
//  FriendListView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

struct FriendListView: View {
    let friends: [FriendInfoModel]

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    OnlineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.top, -30)

                ForEach(friends.filter { $0.isOnline }) {
                    friend in UserCard(userProfile: friend.profile)
                }

                HStack {
                    OfflineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                ForEach(friends.filter { !$0.isOnline }) {
                    friend in UserCard(userProfile: friend.profile)
                }
            }
            .padding(.top, 25)
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    FriendListView(friends: friends)
}
