//
//  bannerNotification.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/07.
//

import SwiftUI

struct bannerNotification: View {
    let encountCount: Int
    @State private var offset: CGFloat = -200
    @State private var opacity: CGFloat = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    bannerNotification()
}
