//
//  LiquidUtil.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/17.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

func withBezier(f: (UIBezierPath) -> ()) -> UIBezierPath {
    let bezierPath = UIBezierPath()
    f(bezierPath)
    bezierPath.closePath()
    return bezierPath
}

func withStroke(bezierPath: UIBezierPath, color: UIColor, f: () -> ()) {
    color.setStroke()
    f()
    bezierPath.stroke()
}

func withFill(bezierPath: UIBezierPath, color: UIColor, f: () -> ()) {
    color.setFill()
    f()
    bezierPath.fill()
}

func appendShadow(layer: CALayer) {
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowRadius = 4.0
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 2, height: 2)
    layer.masksToBounds = false
}

func eraseShadow(layer: CALayer) {
    layer.shadowRadius = 0.0
}

class CGMath {
    static func radToDeg(rad: CGFloat) -> CGFloat {
        return rad * 180 / CGFloat(M_PI)
    }
    
    static func degToRad(deg: CGFloat) -> CGFloat {
        return deg * CGFloat(M_PI) / 180
    }
    
    static func circlePoint(center: CGPoint, radius: CGFloat, rad: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(rad)
        let y = center.y + radius * sin(rad)
        return CGPoint(x: x, y: y)
    }
    
    static func linSpace(from: CGFloat, to: CGFloat, n: Int) -> [CGFloat] {
        var values: [CGFloat] = []
        for i in 0..<n {
            values.append((to - from) * CGFloat(i) / CGFloat(n - 1) + from)
        }
        return values
    }
}