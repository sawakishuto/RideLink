//
//  TabView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/30.
//

import SwiftUI


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
                
                Text("Frired")
                    .tag(Tab.friends)
                
                Text("settings")
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
