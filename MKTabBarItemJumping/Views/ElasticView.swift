//
//  ElasticView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 27.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct ElasticView: View {
    let itemWidth: CGFloat
    let selectedItemIndex: Int
    let isSelected: Bool

    private var springAnimation: Animation {
        Animation
            .spring(dampingFraction: 0.6)
            .delay(0.15)
    }

    var body: some View {
        Color.purple
            .clipShape(TabItemShape(itemWidth: itemWidth,
                                    selectedItemIndex: selectedItemIndex,
                                    isSelected: isSelected))
            .edgesIgnoringSafeArea(.all)
            .animation(isSelected ? springAnimation : .interactiveSpring())
    }
}

struct ElasticView_Previews: PreviewProvider {
    static var previews: some View {
        ElasticView(itemWidth: 200, selectedItemIndex: 1, isSelected: true)
    }
}
