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
        let y = abs(rect.height * sin(value * .pi / 2))
        print("TabItemShape:y - \(y)")

        let cgPath = CGMutablePath()
        cgPath.move(to: .zero)

        let control = CGPoint(x: rect.width / 2, y: y)
        cgPath.addQuadCurve(to: CGPoint(x: rect.width, y: 0), control: control)

        return Path(cgPath)
    }
}
