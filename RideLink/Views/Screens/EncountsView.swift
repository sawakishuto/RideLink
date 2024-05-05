//
//  EncountsView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/06.
//

import SwiftUI

struct EncountsView: View {
    var datalist: [Any] = ["aaa", "vvv", "ccc", "mmm", "aaaaa"]
    var body: some View {
        CarouselBaseView(content: {
            EncountBaseView()
        }, dataList: datalist)
    }
}

#Preview {
    EncountsView()
}
