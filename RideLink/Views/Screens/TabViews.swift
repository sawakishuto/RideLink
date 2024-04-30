//
//  TabView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/30.
//

import SwiftUI


struct TabViews: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = .black

        UITabBar.appearance().backgroundColor = .white
    }
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "figure.stand.line.dotted.figure.stand")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    TabViews()
}
