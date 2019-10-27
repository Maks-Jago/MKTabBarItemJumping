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
    @State var firstSelectedItemIndex: Int = 0
    @State var secondSelectedItemIndex: Int = 0

    @State var jumping: Bool = false
    @State var secondSelected: Bool = true

    private var springAnimation: Animation {
        Animation
            .spring(dampingFraction: 0.6)
            .delay(0.15)
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Color.purple.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .leading) {
                    Color.purple
                        .clipShape(TabItemShape(itemWidth: proxy.size.width / CGFloat(self.items.count),
                                                selectedItemIndex: self.firstSelectedItemIndex,
                                                isSelected: self.jumping))
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 100)
                        .animation(self.jumping ? self.springAnimation : .interactiveSpring())

                    Color.purple
                        .clipShape(TabItemShape(itemWidth: proxy.size.width / CGFloat(self.items.count),
                                                selectedItemIndex: self.secondSelectedItemIndex,
                                                isSelected: self.secondSelected))
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 100)
                    .animation(self.secondSelected ? self.springAnimation : .interactiveSpring())

                    TabItemSelectionView(itemWidth: proxy.size.width / CGFloat(self.items.count),
                                         selectedItemIndex: self.selectedItemIndex,
                                         jumping: self.jumping)

                    HStack(spacing: 0) {
                        ForEach(0..<self.items.count) { index in
                            TabItemView(item: self.items[index],
                                        isSelected: index == self.selectedItemIndex,
                                        onItemSelected: self.onItemSelected)
                        }
                    }
                    .frame(height: 100)
                }
            }
            .background(Color.white)
        }
    }

    func onItemSelected(item: TabItem) {
        selectedItemIndex = items.firstIndex(of: item) ?? 0

        if jumping {
            secondSelectedItemIndex = selectedItemIndex
        } else {
            firstSelectedItemIndex = selectedItemIndex
        }

        jumping.toggle()
        secondSelected.toggle()
    }
}

struct MKTabJumpingView_Previews: PreviewProvider {
    static var previews: some View {
        MKTabJumpingView()
    }
}
