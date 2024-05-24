//
//  TabView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/30.
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

struct TabViews: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var currentTab: Tab =  .map
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                MapView()
                    .tag(Tab.map)

                ContentView()
                    .tag(Tab.encounts)
                
                FriendListView(friends: friends)
                    .tag(Tab.friends)
                
                ProfileView(profileData: ProfileData())
                    .tag(Tab.settings)
            }
            Divider()
            CustomTabViewsStyle(currentTab: $currentTab)
        }
    }
}

#Preview {
    TabViews()
}
