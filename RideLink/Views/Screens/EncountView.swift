//
//  EncountsView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/06.
//

import SwiftUI

struct EncountView: View {
    @ObservedObject private var vm: EncountViewModel
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    let itemPadding: CGFloat = 40

    init(repository: EncounterRepositoryProtocol) {
        self.vm = EncountViewModel(repository: repository)
    }

    var body: some View {
        NavigationStack {
            if !vm.encountInfos.isEmpty {
            GeometryReader { bodyView in
                VStack {

                    LazyHStack(spacing: itemPadding) {
                        ForEach(vm.encountInfos) { vm in
                            EncountBaseView(
                                ImageData: nil,
                                userName: vm.name,
                                bikeName: vm.bike,
                                destinationName: vm.formattedPassedAt ?? "",
                                comment: nil ?? "よろしくお願いいたします！",
                                encountLatitude: vm.latitude ?? 35.00,
                                encountLogitude: vm.longitude ?? 36.00
                            )
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
                                } else if self.currentIndex == (vm.encountInfos.count - 1), value.translation.width < 0 {
                                    state = value.translation.width / 5
                                } else {
                                    state = value.translation.width
                                }
                            })
                            .onEnded({ value in
                                var newIndex = self.currentIndex
                                // ドラッグ幅からページングを判定
                                if abs(value.translation.width) > bodyView.size.width * 0.1 {
                                    newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                                }

                                // 最小ページ、最大ページを超えないようチェック
                                if newIndex < 0 {
                                    newIndex = 0
                                } else if newIndex > (vm.encountInfos.count - 1) {
                                    newIndex = vm.encountInfos.count - 1
                                }

                                self.currentIndex = newIndex
                            })
                    )
                }
                .animation(.interpolatingSpring(mass: 0.6, stiffness: 150, damping: 80, initialVelocity: 0.1))

                Text("\(currentIndex + 1)/\(vm.encountInfos.count)")
                    .fontWeight(.black)
                    .font(.system(size: 20))
                    .offset(x: bodyView.size.width * 0.45, y: bodyView.size.height * 0.90)

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
                    .disabled(currentIndex == 0 ? true: false)
                    .offset(x: bodyView.size.width * 0.1, y: bodyView.size.height * 0.90)

                }
                if currentIndex < vm.encountInfos.count - 1 {
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
                    .offset(x: bodyView.size.width * 0.8, y: bodyView.size.height * 0.90)
                    .disabled(currentIndex == vm.encountInfos.count ? true: false)
                } else {

                }


            }
            } else {
                VStack(alignment: .center, spacing: 30){
                    Text("すれ違った人はいません・・・")
                        .font(.title2)
                        .fontWeight(.black)
                    Text("今すぐツーリングに出よう！🏍️")
                        .font(.title2)
                        .fontWeight(.black)

                }
            }
        }
        .background(Color(hex: "F7F7F7"))
        .ignoresSafeArea()
        .onAppear {
            vm.getEncounter()
        }
    }
}


