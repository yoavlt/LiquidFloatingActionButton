//
//  LiquidFloatingActionButton.swift
//  Pods
//
//  Created by Takuma Yoshida on 2015/08/25.
//
//

import Foundation

public enum LiquidFloatingDirection {
    case Line
    case LiquidLine
    case Circle
    case LiquidCircle
}

private class LiquidFloatingButtonCell : UIButton {
    
    var onPressed: (() -> ())!

    init(frame: CGRect, onPressed: () -> ()) {
        self.onPressed = onPressed
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
    }
}

@IBDesignable
public class LiquidFloatingActionButton : UIView {

    let internalRadiusRatio: CGFloat = 20.0 / 56.0
    
    var isClosed: Bool {
        get {
            return plusRotation == 0
        }
    }
    @IBInspectable var color: UIColor = UIColor(red: 62 / 255.0, green: 83 / 255.0, blue: 219 / 255.0, alpha: 1.0)
    var buttonImages: [UIImage] = []
    let direction: LiquidFloatingDirection
    let plusLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    var touching = false
    var plusRotation: CGFloat = 0
    var baseView = CircleLiquidBaseView()
    var cells: [UIView] = []

    public init(frame: CGRect, direction: LiquidFloatingDirection = .Line) {
        self.direction = direction
        super.init(frame: frame)
        setup()
    }

    required public init(coder aDecoder: NSCoder) {
        self.direction = .Line
        super.init(coder: aDecoder)
        setup()
    }

    public func addCellImage(image: UIImage, onSelected: () -> ()) {
        
    }

    public func addCellView(view: UIView, onSelected: () -> ()) {
        
    }

    public func open() {
        // rotate plus icon
        self.plusLayer.addAnimation(plusKeyframe(isClosed), forKey: "plusRot")
        self.plusRotation = CGFloat(M_PI * 0.25)
        
        self.baseView.open(cells)
    }

    public func close() {
        // rotate plus icon
        self.plusLayer.addAnimation(plusKeyframe(isClosed), forKey: "plusRot")
        self.plusRotation = 0
    
        self.baseView.close(cells)
    }
    
    // MARK: draw icon
    public override func drawRect(rect: CGRect) {
        drawCircle()
        drawShadow()
        drawPlus(plusRotation)
    }
    
    private func drawCircle() {
        self.circleLayer.frame = CGRect(origin: CGPointZero, size: self.frame.size)
        self.circleLayer.cornerRadius = self.frame.width * 0.5
        self.circleLayer.masksToBounds = true
        if touching {
            self.circleLayer.backgroundColor = self.color.white(0.5).CGColor
        } else {
            self.circleLayer.backgroundColor = self.color.CGColor
        }
    }
    
    private func drawPlus(rotation: CGFloat) {
        plusLayer.frame = CGRect(origin: CGPointZero, size: self.frame.size)
        plusLayer.lineCap = kCALineCapRound
        plusLayer.strokeColor = UIColor.whiteColor().CGColor // TODO: customizable
        plusLayer.lineWidth = 3.0

        plusLayer.path = pathPlus(rotation).CGPath
    }
    
    private func drawShadow() {
        appendShadow(self.circleLayer)
    }
    
    private func pathPlus(rotation: CGFloat) -> UIBezierPath {
        let radius = self.frame.width * internalRadiusRatio * 0.5
        let center = self.center.minus(self.frame.origin)
        let points = [
            CGMath.circlePoint(center, radius: radius, rad: rotation),
            CGMath.circlePoint(center, radius: radius, rad: CGFloat(M_PI_2) + rotation),
            CGMath.circlePoint(center, radius: radius, rad: CGFloat(M_PI_2) * 2 + rotation),
            CGMath.circlePoint(center, radius: radius, rad: CGFloat(M_PI_2) * 3 + rotation)
        ]
        let path = UIBezierPath()
        path.moveToPoint(points[0])
        path.addLineToPoint(points[2])
        path.moveToPoint(points[1])
        path.addLineToPoint(points[3])
        return path
    }
    
    private func plusKeyframe(closed: Bool) -> CAKeyframeAnimation {
        var paths = closed ? [
                pathPlus(CGFloat(M_PI * 0)),
                pathPlus(CGFloat(M_PI * 0.125)),
                pathPlus(CGFloat(M_PI * 0.25)),
        ] : [
                pathPlus(CGFloat(M_PI * 0.25)),
                pathPlus(CGFloat(M_PI * 0.375)),
                pathPlus(CGFloat(M_PI * 0.5)),
        ]
        let anim = CAKeyframeAnimation(keyPath: "path")
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.values = paths.map { $0.CGPath }
        anim.duration = 0.5
        anim.removedOnCompletion = true
        anim.fillMode = kCAFillModeForwards
        anim.delegate = self
        return anim
    }

    // MARK: Events
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touching = true
        setNeedsDisplay()
    }
    
    public override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touching = false
        setNeedsDisplay()
        didTapped()
    }
    
    public override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        self.touching = false
        setNeedsDisplay()
    }
    
    public override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        setNeedsDisplay()
    }

    // MARK: private methods
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = false
        
        cells = [
            LiquittableCircle(center: self.center.minus(self.frame.origin), radius: self.frame.width * 0.4, color: self.color),
            LiquittableCircle(center: self.center.minus(self.frame.origin), radius: self.frame.width * 0.4, color: self.color),
            LiquittableCircle(center: self.center.minus(self.frame.origin), radius: self.frame.width * 0.4, color: self.color),
        ]
        for cell in cells {
            addSubview(cell)
        }
        
        baseView.setup(self)
        addSubview(baseView)

        baseView.layer.addSublayer(circleLayer)
        circleLayer.addSublayer(plusLayer)
    }

    private func didTapped() {
        if isClosed {
            open()
        } else {
            close()
        }
    }

}

class ActionBarBaseView : UIView {
    func setup(actionButton: LiquidFloatingActionButton) {
    }
    
    func translateY(layer: CALayer, duration: CFTimeInterval, f: (CABasicAnimation) -> ()) {
        let translate = CABasicAnimation(keyPath: "transform.translation.y")
        f(translate)
        translate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translate.removedOnCompletion = false
        translate.fillMode = kCAFillModeForwards
        translate.duration = duration
        layer.addAnimation(translate, forKey: "transYAnim")
    }
}

class CircleLiquidBaseView : ActionBarBaseView {
    var baseLiquid: LiquittableCircle?
    var engine: SimpleCircleLiquidEngine?
    var connectedLayers: [CAShapeLayer] = []
    override func setup(actionButton: LiquidFloatingActionButton) {
        self.frame = actionButton.frame
        self.center = actionButton.center.minus(actionButton.frame.origin)
        let radius = min(self.frame.width, self.frame.height) * 0.5
        self.engine = SimpleCircleLiquidEngine(radiusThresh: radius, angleThresh: 0.2)
        baseLiquid = LiquittableCircle(center: self.center.minus(self.frame.origin), radius: radius, color: actionButton.color)
        baseLiquid?.clipsToBounds = false
        baseLiquid?.layer.masksToBounds = false
        clipsToBounds = false
        layer.masksToBounds = false
        addSubview(baseLiquid!)
    }
    
    func open(cells: [UIView]) {
        let distance: CGFloat = self.frame.height * 1.25
        for i in 0..<cells.count {
            var cell = cells[i]
            appendShadow(cell.layer)
            cell.layer.removeAllAnimations()
            translateY(cell.layer, duration: 0.5) { translate in
                translate.fromValue = 0
                translate.toValue = CGFloat(i + 1) * -distance
            }
        }
    }
    
    func close(cells: [UIView]) {
        let distance: CGFloat = self.frame.height * 1.25
        for i in 0..<cells.count {
            var cell = cells[i]
            cell.layer.removeAllAnimations()
            eraseShadow(cell.layer)
            translateY(cell.layer, duration: 0.3) { translate in
                translate.fromValue = cell.layer.presentationLayer().valueForKeyPath("transform.translation.y")
                translate.toValue = 0
            }
        }
    }
    
    func keyFrame(paths: [UIBezierPath]) -> CAKeyframeAnimation {
        let anim = CAKeyframeAnimation(keyPath: "path")
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.values = paths.map { $0.CGPath }
        anim.duration = 0.5
        anim.removedOnCompletion = true
        anim.fillMode = kCAFillModeForwards
        anim.delegate = self
        return anim
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        for layer in connectedLayers {
            layer.removeFromSuperlayer()
        }
        connectedLayers = []
    }
}