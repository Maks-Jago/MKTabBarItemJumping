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

struct TabItemView: View {
    let item: TabItem
    let isSelected: Bool
    let onItemSelected: (_ item: TabItem) -> Void

    var body: some View {
        ZStack {
            Color.clear
            Image(systemName: self.item.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .background(Color.clear)
                .offset(y: self.isSelected ? -20 : 0)
                .animation(Animation.easeOut)
        }
        .onTapGesture {
            self.onItemSelected(self.item)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(item: TabItem(iconName: "heart"), isSelected: true) { (selectedIndex) in

        }
    }
}
