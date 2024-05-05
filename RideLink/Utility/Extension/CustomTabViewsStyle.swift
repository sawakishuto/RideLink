//
//  CustomTabViews.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import Foundation
import AudioToolbox
import SwiftUI

struct CustomTabViewsStyle: View {
    @Binding var currentTab: Tab
    var body: some View {
        GeometryReader(content: { g in
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    Button(action: {
                        currentTab = tab
                        AudioServicesPlaySystemSound(1519)
                    }, label: {
                        ZStack() {
                            Image(systemName: tab.synbolName())
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(currentTab == tab ? .green : .gray)
                        }
                    })
                }
            }
            .frame(width: g.size.width)
        })
        .frame(height: 30)
    }
}
