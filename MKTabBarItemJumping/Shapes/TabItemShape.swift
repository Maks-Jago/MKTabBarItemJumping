//
//  TabItemShape.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 21.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct TabItemShape: Shape {

    var value: CGFloat
    let isSelected: Bool

    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }

    init(isSelected: Bool) {
        self.isSelected = isSelected
        value = isSelected ? 1 : 0
    }

    func path(in rect: CGRect) -> Path {
        let y = abs(rect.height * 0.75 * sin(value * .pi / 2))
        print("TabItemShape:y - \(y)")

        let cgPath = CGMutablePath()
//        cgPath.move(to: CGPoint(x: -20, y: 0))
        cgPath.move(to: .zero)

//        cgPath.addQuadCurve(to: CGPoint(x: 0, y: 20), control: CGPoint(x: -30, y: 30))

        let control1 = CGPoint(x: rect.width / 2 - 60, y: y)
        let control2 = CGPoint(x: rect.width / 2 + 60, y: y)
        cgPath.addCurve(to: CGPoint(x: rect.width, y: 0), control1: control1, control2: control2)

        return Path(cgPath)
    }
}
