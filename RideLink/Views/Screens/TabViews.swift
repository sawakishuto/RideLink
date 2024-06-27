//
//  TabView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/30.
//

import SwiftUI

let mock1 = UserProfileModel(
    userName: "1",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let mock2 = UserProfileModel(
    userName: "2",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let mock3 = UserProfileModel(
    userName: "3",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let mock4 = UserProfileModel(
    userName: "4",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let mock5 = UserProfileModel(
    userName: "5",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let mock6 = UserProfileModel(
    userName: "6",
    bikeName: "バイク名",
    profileIcon: nil,
    touringcomment: "コメント"
)

let friends = [
    FriendInfoModel(isOnline: true, profile: mock1),
    FriendInfoModel(isOnline: false, profile: mock2),
    FriendInfoModel(isOnline: true, profile: mock3),
    FriendInfoModel(isOnline: false, profile: mock4),
    FriendInfoModel(isOnline: true, profile: mock5),
    FriendInfoModel(isOnline: false, profile: mock6)
]

struct TabViews: View {
    let encountRepository = EncounterRepository()
    init() {
        UITabBar.appearance().isHidden = true
    }

    @State var currentTab: Tab =  .map
    @EnvironmentObject var routerState: RouterViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                ContentView()
                    .tag(Tab.map)
                EncountView(repository: encountRepository)
                    .tag(Tab.encounts)

                FriendListView()
                    .tag(Tab.friends)
                
                ProfileView()
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
