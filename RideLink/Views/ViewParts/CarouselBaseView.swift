//
//  EncountsView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/06.
//

import SwiftUI

struct CarouselBaseView<Content: View>: View {
    @State private var currentIndex = 0
    @State private var examples = ["1", "2", "3", "4"]
    @GestureState private var dragOffset: CGFloat = 0
    let content: () -> Content
    let dataList: [Any]

    init(@ViewBuilder content: @escaping () ->  Content, dataList: [Any]) {
        self.content = content
        self.dataList = dataList
    }

    let itemPadding: CGFloat = 40

    var body: some View {
        GeometryReader { bodyView in
            VStack {

                LazyHStack(spacing: itemPadding) {
                    ForEach(dataList.indices, id: \.self) { index in
                        content()
                            .frame(width: bodyView.size.width * 1.0)
                    }

                }
                .offset(x: self.dragOffset * 0.5)
                .offset(x: -CGFloat(self.currentIndex) * (bodyView.size.width * 1.0 + itemPadding))
                .gesture(
                    DragGesture()
                        .updating(self.$dragOffset, body: { (value, state, _) in
                            // 先頭・末尾ではスクロールする必要がないので、画面サイズの1/5までドラッグで制御する
                            if self.currentIndex == 0, value.translation.width > 0 {
                                state = value.translation.width / 5
                            } else if self.currentIndex == (self.dataList.count - 1), value.translation.width < 0 {
                                state = value.translation.width / 5
                            } else {
                                state = value.translation.width
                            }
                        })
                        .onEnded({ value in
                            var newIndex = self.currentIndex
                            // ドラッグ幅からページングを判定
                            if abs(value.translation.width) > bodyView.size.width * 0.4 {
                                newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                            }

                            // 最小ページ、最大ページを超えないようチェック
                            if newIndex < 0 {
                                newIndex = 0
                            } else if newIndex > (self.dataList.count - 1) {
                                newIndex = self.dataList.count - 1
                            }

                            self.currentIndex = newIndex
                        })
                )
            }
            Text("\(currentIndex + 1)/\(dataList.count)")
                .fontWeight(.black)
                .font(.system(size: 20))
                .offset(x: bodyView.size.width * 0.45, y: bodyView.size.height * 0.85)

            Text("今日はこんなライダーとすれ違いました！")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .offset(x: bodyView.size.width * 0.05, y: bodyView.size.height * 0.1)
            if currentIndex > 0 {
                Button(action: {
                    currentIndex -= 1
                }, label: {
                    ZStack(alignment: .center) {
                        Image(systemName: "arrowtriangle.backward")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 28, height: 28)


                    }
                })
                .offset(x: bodyView.size.width * 0.1, y: bodyView.size.height * 0.85)
            }
            if currentIndex < dataList.count - 1 {
                Button(action: {
                    currentIndex += 1
                }, label: {
                    ZStack {

                        Image(systemName: "arrowtriangle.right")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 28, height: 28)
                    }
                })
                .offset(x: bodyView.size.width * 0.8, y: bodyView.size.height * 0.85)
            }

        }

        .background(Color(hex: "F8F8F8"))
        .ignoresSafeArea()
        .animation(.interpolatingSpring(mass: 0.6, stiffness: 150, damping: 80, initialVelocity: 0.1))
    }
}


