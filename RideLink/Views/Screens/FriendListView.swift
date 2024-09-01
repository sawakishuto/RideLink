//
//  FriendListView.swift
//  RideLink
//
//  Created by 株丹優一郎 on 2024/05/17.
//

import SwiftUI

struct FriendListView: View {
    @StateObject var vm = FriendListViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    OnlineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.top, 30)

                ForEach(vm.friendList.filter { $0.isTouring! }) {
                    friend in UserCard(
                        userProfile: UserProfileModel(uuid: friend.uuid, name: friend.name, bike: friend.bike)
                    )
                    .padding(.bottom, 25)

                }

                HStack {
                    OfflineIndicator()
                        .padding(.leading, 15)
                    Spacer()
                }
                .padding(.top, vm.friendList.isEmpty ? 100: 10)
                .padding(.bottom, 10)

                ForEach(vm.friendList.filter { !$0.isTouring! }) {
                    friend in UserCard(
                        userProfile: UserProfileModel(uuid: friend.uuid, name: friend.name, bike: friend.bike)
                    )
                    .padding(.bottom, 25)
                }
            }
            .padding(.top, 25)
            .padding(.bottom, 10)
        }
        .background(Color(hex: "F8F8F8"))   
        .ignoresSafeArea()

    }
}
