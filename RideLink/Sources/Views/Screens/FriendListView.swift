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
                    friend in UserCard(
                        userIcon: nil,
                        userName: "カブタン",
                        bikeName: "YZF-R15",
                        comment: "ディズニー行く"
                    )
                    .padding(.bottom, 25)

                }

                HStack {
                    OfflineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                ForEach(friends.filter { !$0.isOnline }) {
                    friend in UserCard(
                        userIcon: nil,
                        userName: "ブタン",
                        bikeName: "DSC400",
                        comment: "ご飯食べたい"
                    )
                    .padding(.bottom, 25)
                }
            }
            .padding(.top, 25)
            .padding(.bottom, 10)
        }
        .background(Color(hex: "F8F8F8"))
    }
}

#Preview {
    FriendListView(friends: friends)
}
