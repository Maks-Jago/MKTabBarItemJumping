//
//  TabItemView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 19.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct TabItem: Equatable {
    let iconName: String
}

private struct TabItemIcon : ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .background(Color.clear)
            .animation(Animation.easeInOut.delay(0.1))
    }
}

struct TabItemView: View {
    let item: TabItem
    let isSelected: Bool
    let onItemSelected: (_ item: TabItem) -> Void

    var body: some View {
        ZStack {
            Color.clear

            Image(systemName: self.item.iconName)
                .resizable()
                .modifier(TabItemIcon())
                .foregroundColor(Color.white)
                .opacity(self.isSelected ? 1 : 0)

            Image(systemName: self.item.iconName)
                .resizable()
                .modifier(TabItemIcon())
                .foregroundColor(Color.black)
                .opacity(self.isSelected ? 0 : 1)
        }
        .offset(y: self.isSelected ? -15 : 0)
        .animation(Animation.easeOut)
        .onTapGesture {
            self.onItemSelected(self.item)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabItemView(item: TabItem(iconName: "pin.circle"), isSelected: false) { (selectedIndex) in

            }
            .background(Color.gray)

            TabItemView(item: TabItem(iconName: "heart"), isSelected: true) { (selectedIndex) in

            }
            .background(Color.black)
        }
    }
}
