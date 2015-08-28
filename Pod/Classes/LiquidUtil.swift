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

extension CALayer {
    func appendShadow() {
        shadowColor = UIColor.blackColor().CGColor
        shadowRadius = 2.0
        shadowOpacity = 0.1
        shadowOffset = CGSize(width: 4, height: 4)
        masksToBounds = false
    }
    
    func eraseShadow() {
        shadowRadius = 0.0
        shadowColor = UIColor.clearColor().CGColor
    }
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