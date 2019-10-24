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

    func quadCurvedPathWithPoint(points: [CGPoint] ) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count > 1 {
            var prevPoint:CGPoint?
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    if index == 1 {
                        path.addLine(to: point)
                    }
                    if prevPoint != nil {
                        let midPoint = self.midPointForPoints(from: prevPoint!, to: point)
                        path.addQuadCurve(to: midPoint, controlPoint: controlPointForPoints(from: midPoint, to: prevPoint!))
                        path.addQuadCurve(to: point, controlPoint: controlPointForPoints(from: midPoint, to: point))
                    }
                }
                prevPoint = point
            }
        }
        return path
    }

    func midPointForPoints(from p1:CGPoint, to p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }

    func controlPointForPoints(from p1:CGPoint,to p2:CGPoint) -> CGPoint {
        var controlPoint = midPointForPoints(from:p1, to: p2)
        let  diffY = abs(p2.y - controlPoint.y)
        if p1.y < p2.y {
            controlPoint.y = controlPoint.y + diffY
        } else if ( p1.y > p2.y ) {
            controlPoint.y = controlPoint.y - diffY
        }
        return controlPoint
    }

    func path(in rect: CGRect) -> Path {
        let y = abs(rect.height * 0.7 * value) //sin(value * .pi / 2))
        let offsetXDelta: CGFloat = 30

//        CGSize(width: itemWidth / 2 - 30 + CGFloat(selectedItemIndex) * itemWidth
        let offsetX = (itemWidth / 2 - 37 + CGFloat(selectedItemIndex) * itemWidth)
        let points = [
            CGPoint(x: offsetX - offsetXDelta, y: 0),
            CGPoint(x: offsetX, y: 30),
            CGPoint(x: offsetX, y: y),
            CGPoint(x: offsetX + itemWidth, y: y),
            CGPoint(x: offsetX + itemWidth, y: 30),
            CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0)
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

        return Path(linePath.cgPath)





        let cgPath = CGMutablePath()
        cgPath.move(to: CGPoint(x: offsetX - 120, y: 0))

        let quadControl1 = CGPoint(x: offsetX - offsetXDelta - 10, y: -15)

        cgPath.addQuadCurve(to: CGPoint(x: offsetX - offsetXDelta, y: 30), control: quadControl1)

//        cgPath.move(to: CGPoint(x: offsetX - offsetXDelta, y: 30))

        let control1 = CGPoint(x: offsetX - offsetXDelta - 5, y: y) //CGPoint(x: offsetX + 25, y: 20)
        let control2 = CGPoint(x: offsetX + itemWidth + offsetXDelta, y: y)

        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 30),
                        control1: control1,
                        control2: control2)

        let quadControl2 = CGPoint(x: offsetX + itemWidth + offsetXDelta + 20, y: -15)

        cgPath.addQuadCurve(to: CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0),
                            control: quadControl2)


//        cgPath.addLine(to: CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0))

        return Path(cgPath)

//        let offsetX = CGFloat(selectedItemIndex) * itemWidth + 2 //itemWidth * CGFloat(selectedItemIndex)
//        let centerX = offsetX + itemWidth / 2
//
//        cgPath.move(to: CGPoint(x: offsetX - offsetXDelta, y: 0))
//
//        let control1 = CGPoint(x: centerX - 25, y: 20) //CGPoint(x: offsetX + 25, y: 20)
//        let control4 = CGPoint(x: centerX + 25, y: 20) //CGPoint(x: offsetX + itemWidth / 2 + 10, y: 20)
//
//        let control2 = CGPoint(x: centerX - 55, y: y) //CGPoint(x: offsetX - 10, y: y)
//        let control3 = CGPoint(x: centerX + 55, y: y)
//
//        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth / 2, y: y),
//                        control1: control1,
//                        control2: control2)
//
//        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0),
//                        control1: control3,
//                        control2: control4)
//
//        return Path(cgPath)

//        let y = abs(rect.height * 0.55 * value) //sin(value * .pi / 2))
//        let offsetXDelta: CGFloat = 30
//
//        let cgPath = CGMutablePath()
//        let offsetX = itemWidth * CGFloat(selectedItemIndex)
//        cgPath.move(to: CGPoint(x: offsetX - offsetXDelta, y: 0))
//
//        let control1 = CGPoint(x: offsetX + 25, y: 20)
//        let control2 = CGPoint(x: offsetX - 10, y: y)
//
//        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth / 2, y: y),
//                        control1: control1,
//                        control2: control2)
//
//        let control3 = CGPoint(x: offsetX + itemWidth + 10, y: y)
//        let control4 = CGPoint(x: offsetX + itemWidth / 2 + 10, y: 20)
//
//        cgPath.addCurve(to: CGPoint(x: offsetX + itemWidth + offsetXDelta, y: 0),
//                        control1: control3,
//                        control2: control4)
//
//        return Path(cgPath)
    }
}


struct TabItemShape_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { proxy in
            VStack {
                Color.green.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .leading) {
                    Color.gray
                        .clipShape(TabItemShape(itemWidth: proxy.size.width / 4,
                                                selectedItemIndex: 2,
                                                isSelected: true))
                        .edgesIgnoringSafeArea(.all)
                        .padding(.top, -8)
                        .frame(height: 100)
                        .animation(.spring())
                }
            }

        }
    }
}
