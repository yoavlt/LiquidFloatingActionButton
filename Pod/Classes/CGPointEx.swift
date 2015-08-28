//
//  CGPointEx.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/17.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    
    // 足し算
    func plus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
    
    // 引き算
    func minus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - point.x, y: self.y - point.y)
    }

    func minusX(dx: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - dx, y: self.y)
    }
    
    func minusY(dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y - dy)
    }
    
    // 掛け算
    func mul(rhs: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * rhs, y: self.y * rhs)
    }
    
    // 割り算
    func div(rhs: CGFloat) -> CGPoint {
        return CGPoint(x: self.x / rhs, y: self.y / rhs)
    }
    
    // 長さ
    func length() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
    
    // 正規化
    func normalized() -> CGPoint {
        return self.div(self.length())
    }

    // 内積
    func dot(point: CGPoint) -> CGFloat {
        return self.x * point.x + self.y * point.y
    }

    // 外積
    func cross(point: CGPoint) -> CGFloat {
        return self.x * point.y - self.y * point.x
    }
    
    func split(point: CGPoint, ratio: CGFloat) -> CGPoint {
        return self.mul(ratio).plus(point.mul(1.0 - ratio))
    }
    
    func mid(point: CGPoint) -> CGPoint {
        return split(point, ratio: 0.5)
    }
    
    static func intersection(from: CGPoint, to: CGPoint, from2: CGPoint, to2: CGPoint) -> CGPoint? {
        let ac = CGPoint(x: to.x - from.x, y: to.y - from.y)
        let bd = CGPoint(x: to2.x - from2.x, y: to2.y - from2.y)
        let ab = CGPoint(x: from2.x - from.x, y: from2.y - from.y)
        let bc = CGPoint(x: to.x - from2.x, y: to.y - from2.y)

        let area = bd.cross(ab)
        let area2 = bd.cross(bc)

        if abs(area + area2) >= 0.1 {
            let ratio = area / (area + area2)
            return CGPoint(x: from.x + ratio * ac.x, y: from.y + ratio * ac.y)
        }

        return nil
    }
    
}