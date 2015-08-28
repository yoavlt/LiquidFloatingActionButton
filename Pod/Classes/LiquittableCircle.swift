//
//  LiquittableCircle.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/17.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

public class LiquittableCircle : UIView {

    var points: [CGPoint] = []
    var radius: CGFloat
    var color: UIColor = UIColor.redColor() {
        didSet {
            setup()
        }
    }

    let circleLayer = CAShapeLayer()
    var dt: CGPoint {
        get {
            var dx: CGFloat = 0
            var dy: CGFloat = 0
            if let ddx = self.layer.presentationLayer().valueForKeyPath("transform.translation.y") as? CGFloat {
                dx = ddx
            }
            if let ddy = self.layer.presentationLayer().valueForKeyPath("transform.translation.y") as? CGFloat {
                dy = ddy
            }
            return CGPoint(x: dx, y: dy)
        }
    }

    init(center: CGPoint, radius: CGFloat, color: UIColor) {
        let frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        self.radius = radius
        self.color = color
        super.init(frame: frame)
        setup()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        let bezierPath = UIBezierPath(ovalInRect: CGRect(origin: CGPointZero, size: CGSize(width: radius * 2, height: radius * 2)))
        let layer = draw(bezierPath)
        self.layer.addSublayer(layer)
    }

    func draw(path: UIBezierPath) -> CAShapeLayer {
        self.layer.sublayers?.each { $0.removeFromSuperlayer() }
        circleLayer.lineWidth = 3.0
        circleLayer.fillColor = self.color.CGColor
        circleLayer.path = path.CGPath
        return circleLayer
    }

    func circlePoint(rad: CGFloat) -> CGPoint {
        return CGMath.circlePoint(center.plus(dt), radius: radius, rad: rad)
    }

}