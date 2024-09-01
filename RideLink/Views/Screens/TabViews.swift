//
//  TabView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/30.
//

import SwiftUI

struct TabViews: View {
    let encountRepository = EncounterRepository()
    init() {
        UITabBar.appearance().isHidden = true
    }

    @State var currentTab: Tab = .map
    @EnvironmentObject var routerState: RouterViewModel

    var body: some View {
        GeometryReader { geometry in
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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // タブの動きをなくすスタイルを適用

                Divider()
                CustomTabViewsStyle(currentTab: $currentTab)
                    .frame(width: geometry.size.width, height: 80) // カスタムタブの高さを設定
                    .background(Color.white) // タブバーの背景色を設定
                    .clipShape(Rectangle()) // 角丸を設定
            }
            .edgesIgnoringSafeArea(.bottom) // 下部の安全エリアを無視して全画面表示
        }
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
