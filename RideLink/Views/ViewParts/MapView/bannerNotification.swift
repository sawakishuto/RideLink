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
        let asyncHide = DispatchWorkItem() {hide()}
        let asyncShow = DispatchWorkItem() {show()}
    }
}

#Preview {
    bannerNotification()
}
