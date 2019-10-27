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
        self.itemWidth = CGFloat(Int(itemWidth))
        self.selectedItemIndex = selectedItemIndex
        self.isSelected = isSelected
        value = isSelected ? 1 : 0
    }

    func path(in rect: CGRect) -> Path {
        let y = abs(rect.height * 0.47 * value)
        let offsetXDelta: CGFloat = 34

        let offsetX = (itemWidth / 2 - 38 + CGFloat(selectedItemIndex) * itemWidth)
        let offsetY = abs(20 * sin(value * .pi / 2))

        let points = [
            CGPoint(x: offsetX - offsetXDelta, y: 0.1),
            CGPoint(x: offsetX - 10, y: offsetY),
            CGPoint(x: offsetX + 15, y: y),
            CGPoint(x: offsetX + itemWidth - 15, y: y),
            CGPoint(x: offsetX + itemWidth + 10, y: offsetY),
            CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0.1)
        ]

        let controlPoints = CubicCurveAlgorithm().controlPointsFromPoints(dataPoints: points)
        let linePath = UIBezierPath()

        for i in 0..<points.count {
            let point = points[i];

            if i==0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }

        let shapePath = UIBezierPath()
        shapePath.append(linePath)
        shapePath.addLine(to: CGPoint(x: rect.width, y: 0))
        shapePath.addLine(to: .zero)

        return Path(shapePath.cgPath)
    }
}


struct TabItemShape_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Color.green.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .leading) {
                    Color.gray
                        .clipShape(TabItemShape(itemWidth: proxy.size.width / 4,
                                                selectedItemIndex: 2,
                                                isSelected: true))
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 100)
                        .animation(.spring())
                }
            }

        }
    }
}
