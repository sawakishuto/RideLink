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
        GeometryReader { geometory in
            VStack{
                Text("ヤエーー！！🖐️")
                    .frame(alignment: .leading)
                Text("\(String(encountCount))人とすれ違いました！🎉")
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 20)
            .font(.system(size: 20))
            .background(.white)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.green, lineWidth: 5)
            }
        }
        .onTapGesture {
            asyncHide.cancel()
            hide()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: asyncShow)

            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: asyncHide)
        }
        .offset(y: offset)
    }
    }
}

#Preview {
    bannerNotification()
}
