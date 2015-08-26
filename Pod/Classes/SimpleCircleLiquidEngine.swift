//
//  SimpleCircleLiquidEngine.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/19.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class is so fast, but allowed only same color.
 */
class SimpleCircleLiquidEngine {

    let radiusThresh: CGFloat
    private var layer: CALayer = CAShapeLayer()

    var color = UIColor.redColor()
    
    let ConnectThresh: CGFloat = 0.3
    var angleThresh: CGFloat = 0.5
    
    init(radiusThresh: CGFloat, angleThresh: CGFloat) {
        self.radiusThresh = radiusThresh
        self.angleThresh = angleThresh
    }

    func push(circle: LiquittableCircle, other: LiquittableCircle) -> [LiquittableCircle] {
        if let paths = generateConnectedPath(circle, other: other) {
            let layers = paths.map(self.constructLayer)
            layers.each(layer.addSublayer)
            return [circle, other]
        }
        return []
    }
    
    func draw(parent: UIView) {
        parent.layer.addSublayer(layer)
    }

    func clear() {
        layer.removeFromSuperlayer()
        layer.sublayers?.each{ $0.removeFromSuperlayer() }
        layer = CAShapeLayer()
    }

    func constructLayer(path: UIBezierPath) -> CALayer {
        let pathBounds = CGPathGetBoundingBox(path.CGPath);

        let shape = CAShapeLayer()
        shape.fillColor = self.color.CGColor
        shape.path = path.CGPath
        shape.frame = CGRect(x: 0, y: 0, width: pathBounds.width, height: pathBounds.height)
        
        return shape
    }
    
    private func circleConnectedPoint(circle: LiquittableCircle, other: LiquittableCircle, angle: CGFloat) -> (CGPoint, CGPoint) {
        let vec = other.center.minus(circle.center)
        let radian = atan2(vec.y, vec.x)
        let p1 = circle.circlePoint(radian + angle)
        let p2 = circle.circlePoint(radian - angle)
        return (p1, p2)
    }
    
    private func circleConnectedPoint(circle: LiquittableCircle, other: LiquittableCircle) -> (CGPoint, CGPoint) {
        var ratio = circleRatio(circle, other: other)
        ratio = (ratio + ConnectThresh) / (1.0 + ConnectThresh)
        let angle = CGFloat(M_PI_2) * ratio
        return circleConnectedPoint(circle, other: other, angle: angle)
    }

    func generateConnectedPath(circle: LiquittableCircle, other: LiquittableCircle) -> [UIBezierPath]? {
        if isConnected(circle, other: other) {
            let ratio = circleRatio(circle, other: other)
            switch ratio {
            case angleThresh...1.0:
                if let path = normalPath(circle, other: other) {
                    return [path]
                }
                return nil
            case 0.0..<angleThresh:
                return splitPath(circle, other: other, ratio: ratio)
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    private func normalPath(circle: LiquittableCircle, other: LiquittableCircle) -> UIBezierPath? {
        let (p1, p2) = circleConnectedPoint(circle, other: other)
        let (p3, p4) = circleConnectedPoint(other, other: circle)
        if let crossed = CGPoint.intersection(p1, to: p3, from2: p2, to2: p4) {
            return withBezier { path in
                let r = self.circleRatio(circle, other: other)
                path.moveToPoint(p1)
                let mul = p1.plus(p4).div(2).split(crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurveToPoint(p4, controlPoint: mul)
                path.addLineToPoint(p3)
                let mul2 = p2.plus(p3).div(2).split(crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurveToPoint(p2, controlPoint: mul2)
            }
        }
        return nil
    }

    private func splitPath(circle: LiquittableCircle, other: LiquittableCircle, ratio: CGFloat) -> [UIBezierPath] {
        let (p1, p2) = circleConnectedPoint(circle, other: other, angle: CGMath.degToRad(40))
        let (p3, p4) = circleConnectedPoint(other, other: circle, angle: CGMath.degToRad(40))

        if let crossed = CGPoint.intersection(p1, to: p3, from2: p2, to2: p4) {
            let (d1, _d1) = self.circleConnectedPoint(circle, other: other, angle: 0)
            let (d2, _d2) = self.circleConnectedPoint(other, other: circle, angle: 0)
            let r = (ratio - ConnectThresh) / (angleThresh - ConnectThresh)

            let a1 = d1.split(crossed.mid(d2), ratio: 1 - r)
            let part = withBezier { path in
                path.moveToPoint(p1)
                let cp1 = a1.split(p1, ratio: ratio)
                let cp2 = a1.split(p2, ratio: ratio)
                path.addQuadCurveToPoint(p2, controlPoint: a1)
            }
            let a2 = d2.split(crossed.mid(d1), ratio: 1 - r)
            let part2 = withBezier { path in
                path.moveToPoint(p3)
                let cp1 = a2.split(p3, ratio: ratio)
                let cp2 = a2.split(p4, ratio: ratio)
                path.addQuadCurveToPoint(p4, controlPoint: a2)
            }
            return [part, part2]
        }
        return []
    }

    private func circleRatio(circle: LiquittableCircle, other: LiquittableCircle) -> CGFloat {
        let distance = other.center.minus(circle.center).length()
        let ratio = 1.0 - (distance - radiusThresh) / (circle.radius + other.radius + radiusThresh)
        return min(max(ratio, 0.0), 1.0)
    }

    func isConnected(circle: LiquittableCircle, other: LiquittableCircle) -> Bool {
        let distance = circle.center.minus(other.center).length()
        return distance - circle.radius - other.radius < radiusThresh
    }

}
