//
//  FriendListView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

let mock1 = UserProfileModel(
    uid: "1",
    userName: "1",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let mock2 = UserProfileModel(
    uid: "2",
    userName: "2",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let mock3 = UserProfileModel(
    uid: "3",
    userName: "3",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let mock4 = UserProfileModel(
    uid: "4",
    userName: "4",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let mock5 = UserProfileModel(
    uid: "5",
    userName: "5",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let mock6 = UserProfileModel(
    uid: "6",
    userName: "6",
    bikeName: "バイク名",
    profileIcon: "orangeBike",
    comment: "コメント"
)

let friends = [
    FrendInfoModel(isOnline: true, profile: mock1),
    FrendInfoModel(isOnline: false, profile: mock2),
    FrendInfoModel(isOnline: true, profile: mock3),
    FrendInfoModel(isOnline: false, profile: mock4),
    FrendInfoModel(isOnline: true, profile: mock5),
    FrendInfoModel(isOnline: false, profile: mock6)
]

struct FriendListView: View {
    let friends: [FrendInfoModel]

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

                ForEach(friends.filter { $0.isOnline }, id: \.profile.uid) {
                    friend in UserCard(userProfile: friend.profile)
                }

                HStack {
                    OfflineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                ForEach(friends.filter { !$0.isOnline }, id: \.profile.uid) {
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
