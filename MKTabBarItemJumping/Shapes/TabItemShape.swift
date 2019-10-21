//
//  TabItemShape.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 21.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct TabItemShape: Shape {

    let itemWidth: CGFloat
    let selectedItemIndex: Int

    var value: CGFloat
    let isSelected: Bool

    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }

    init(itemWidth: CGFloat, selectedItemIndex: Int, isSelected: Bool) {
        self.itemWidth = itemWidth
        self.selectedItemIndex = selectedItemIndex
        self.isSelected = isSelected
        value = isSelected ? 1 : 0
    }

    func path(in rect: CGRect) -> Path {
        let y = abs(rect.height * 0.75 * value) //sin(value * .pi / 2))
        print("TabItemShape:y - \(y)")

        let cgPath = CGMutablePath()
        let offsetX = itemWidth * CGFloat(selectedItemIndex)
        cgPath.move(to: CGPoint(x: offsetX - 30, y: 0))

        cgPath.addLine(to: CGPoint(x: offsetX, y: y / 2))

        cgPath.addLine(to: CGPoint(x: offsetX + itemWidth / 2, y: y))

        cgPath.addLine(to: CGPoint(x: offsetX + itemWidth, y: y / 2))

        cgPath.addLine(to: CGPoint(x: offsetX + itemWidth + 30, y: 0))

        /*
        cgPath.move(to: CGPoint(x: offsetX - 30, y: 0)) //CGPoint(x: -40, y: 0))
        cgPath.addQuadCurve(to: CGPoint(x: offsetX, y: y / 2), control: CGPoint(x: offsetX + 10, y: 30))
//        cgPath.move(to: .zero)

//        cgPath.addQuadCurve(to: CGPoint(x: 0, y: 20), control: CGPoint(x: -30, y: 30))

        let control1 = CGPoint(x: offsetX + itemWidth - 60, y: y)
        let control2 = CGPoint(x: offsetX + itemWidth + 60, y: y)
        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth, y: y / 2), control1: control1, control2: control2)


        cgPath.addQuadCurve(to: CGPoint(x: offsetX + itemWidth - 30, y: 0), control: CGPoint(x: offsetX + itemWidth - 10, y: 30))
 */
        return Path(cgPath)
    }
}
