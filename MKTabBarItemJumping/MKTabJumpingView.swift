//
//  MKTabJumpingView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 29.09.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct MKTabJumpingView: View {
    private var items: [TabItem] = [.init(iconName: "heart"),
                                    .init(iconName: "pin.circle"),
                                    .init(iconName: "clock"),
                                    .init(iconName: "bell"),
                                    .init(iconName: "person")]

    @State var selectedItemIndex: Int = 0
    @State var jumping: Bool = false

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .leading) {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.darkGreen, .lightGreen]),
                                           startPoint: .bottomLeading, endPoint: .topTrailing)
                        )
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        .offset(y: -20)
                        .modifier(JumpingEffect(itemWidth: proxy.size.width / CGFloat(self.items.count),
                                                selectedItemIndex: self.selectedItemIndex,
                                                jumping: self.jumping))
                        .animation(.linear)

                    HStack(spacing: 0) {
                        ForEach(0..<self.items.count) { index in
                            TabItemView(item: self.items[index],
                                        isSelected: index == self.selectedItemIndex,
                                        onItemSelected: self.onItemSelected)
                        }
                    }
                    .frame(height: 90)
                }
            }
        }
    }

    func onItemSelected(item: TabItem) {
        selectedItemIndex = items.firstIndex(of: item) ?? 0
        jumping.toggle()
    }
}

struct JumpingEffect: GeometryEffect {
    private var offset: CGSize

    init(itemWidth: CGFloat, selectedItemIndex: Int, jumping: Bool) {
        offset = CGSize(width: itemWidth / 2 - 30 + CGFloat(selectedItemIndex) * itemWidth,
                        height: jumping ? 1 : 0)
    }

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
