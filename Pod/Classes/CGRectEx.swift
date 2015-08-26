//
//  CGRectEx.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/20.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    var rightBottom: CGPoint {
        get {
            return CGPoint(x: origin.x + width, y: origin.y + height)
        }
    }
    var center: CGPoint {
        get {
            return origin.plus(rightBottom).mul(0.5)
        }
    }
}
