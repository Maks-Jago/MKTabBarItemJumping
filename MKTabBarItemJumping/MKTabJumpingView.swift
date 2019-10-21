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
                    HStack(spacing: 0) {
                        ForEach(0..<self.items.count) { index in
                            Color.gray
                                .clipShape(TabItemShape(isSelected: index == self.selectedItemIndex))
                                .edgesIgnoringSafeArea(.all)
                                .animation(.spring())
                        }
                    }
                    .padding(.top, -10)
                    .frame(height: 100)

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

struct MKTabJumpingView_Previews: PreviewProvider {
    static var previews: some View {
        MKTabJumpingView()
    }
}
