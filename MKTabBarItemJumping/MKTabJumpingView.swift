//
//  MKTabJumpingView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 29.09.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct MKTabJumpingView: View {
    @State var selectedItem: Int = 0
    @State var value: Bool = false

    var body: some View {
        let itemWidthCalculator = { (width: CGFloat) -> CGFloat in
            width / 4.0
        }

        return GeometryReader { proxy in
            VStack {
                Spacer()
                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.red)
                            .onTapGesture {
                                self.selectedItem = 0
                                self.value.toggle()
                        }
                        Rectangle()
                            .foregroundColor(.green)
                            .onTapGesture {
                                self.selectedItem = 1
                                self.value.toggle()
                        }
                        Rectangle()
                            .foregroundColor(.blue)
                            .onTapGesture {
                                self.selectedItem = 2
                                self.value.toggle()
                        }
                        Rectangle()
                            .foregroundColor(.orange)
                            .onTapGesture {
                                self.selectedItem = 3
                                self.value.toggle()
                        }
                    }.frame(height: 90)

                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.clear)
                        .background(LinearGradient(gradient:
                            Gradient(colors: [.red, .blue]),
                                                   startPoint: .bottom,
                                                   endPoint: .top))
                        .clipShape(Circle())
                        .shadow(radius: 20)
                    .modifier(MyEffect(offset: CGSize(width: itemWidthCalculator(proxy.size.width) / 2 - 30 + CGFloat(self.selectedItem) * itemWidthCalculator(proxy.size.width),
                                                      height: self.value ? 1 : 0)))
//                        .modifier(MyEffect(x: itemWidthCalculator(proxy.size.width) / 2 - 30 + CGFloat(self.selectedItem) * itemWidthCalculator(proxy.size.width), y: 50))
//                        .modifier(MyEffect(x: itemWidthCalculator(proxy.size.width) / 2 - 30 + CGFloat(self.selectedItem) * itemWidthCalculator(proxy.size.width),
//                                           fromX: itemWidthCalculator(proxy.size.width) / 2 - 30 + CGFloat(self.selectedItem - 1) * itemWidthCalculator(proxy.size.width)))
                        .animation(.linear)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


//struct MyEffect: GeometryEffect {
//    var x: CGFloat
//    private var result: CGFloat
//    private var initialValue: CGFloat
//
//    init(x: CGFloat, fromX: CGFloat) {
//        self.x = x
//        result = x
//        initialValue = max(fromX, 0)
//    }
//
//    var animatableData: CGFloat {
//        get { x }
//        set { x = newValue }
//    }
//
//    func effectValue(size: CGSize) -> ProjectionTransform {
//        let value = min(x - 30, result - 30) / max(x - 30, result - 30)
//        let y = -50 * sin(value * .pi)
//        print(y)
//        return ProjectionTransform(CGAffineTransform(translationX: x, y: y))
//    }
//}

struct MyEffect: GeometryEffect {
    var offset: CGSize

    var animatableData: CGSize.AnimatableData {
        get { CGSize.AnimatableData(offset.width, offset.height) }
        set { offset = CGSize(width: newValue.first, height: newValue.second) }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let y = -1 * abs(80 * sin(offset.height * .pi))
        return ProjectionTransform(CGAffineTransform(translationX: offset.width, y: y))
    }
}


struct MKTabJumpingView_Previews: PreviewProvider {
    static var previews: some View {
        MKTabJumpingView()
    }
}
