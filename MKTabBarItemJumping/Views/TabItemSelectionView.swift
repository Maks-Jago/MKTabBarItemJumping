//
//  TabItemSelectionView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 19.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct TabItemSelectionView: View {
    let itemWidth: CGFloat
    let selectedItemIndex: Int
    let jumping: Bool

    var body: some View {
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
            .modifier(JumpingEffect(itemWidth: itemWidth,
                                    selectedItemIndex: selectedItemIndex,
                                    jumping: jumping))
            .animation(Animation.linear.speed(1))
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


struct TabItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemSelectionView(itemWidth: 100, selectedItemIndex: 1, jumping: false)
    }
}
