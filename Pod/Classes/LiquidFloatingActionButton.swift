//
//  LiquidFloatingActionButton.swift
//  Pods
//
//  Created by Takuma Yoshida on 2015/08/25.
//
//

import Foundation
import QuartzCore

@objc public protocol LiquidFloatingActionButtonDataSource {
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int
    func cellForIndex(index: Int) -> LiquidFloatingCell
}

@objc public protocol LiquidFloatingActionButtonDelegate {
    optional func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int)
}

@IBDesignable
public class LiquidFloatingActionButton : UIView {

    private let internalRadiusRatio: CGFloat = 20.0 / 56.0
    public var cellRadiusRatio: CGFloat      = 0.38
    
    public var delegate:   LiquidFloatingActionButtonDelegate?
    public var dataSource: LiquidFloatingActionButtonDataSource?
    
    public var responsible = true
    public var isClosed: Bool {
        get {
            return plusRotation == 0
        }
    }

    @IBInspectable public var color: UIColor = UIColor(red: 82 / 255.0, green: 112 / 255.0, blue: 235 / 255.0, alpha: 1.0)

    private let plusLayer   = CAShapeLayer()
    private let circleLayer = CAShapeLayer()

    private var touching = false
    private var plusRotation: CGFloat = 0

    private var baseView = CircleLiquidBaseView()
    private let liquidView = UIView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func insertCell(cell: LiquidFloatingCell) {
        cell.color  = self.color
        cell.radius = self.frame.width * cellRadiusRatio
        cell.center = self.center.minus(self.frame.origin)
        insertSubview(cell, aboveSubview: baseView)
    }
    
    private func cellArray() -> [LiquidFloatingCell] {
        var result: [LiquidFloatingCell] = []
        if let source = dataSource {
            for i in 0..<source.numberOfCells(self) {
                result.append(source.cellForIndex(i))
            }
        }
        return result
    }

    // open all cells
    public func open() {
        // rotate plus icon
        self.plusLayer.addAnimation(plusKeyframe(true), forKey: "plusRot")
        self.plusRotation = CGFloat(M_PI * 0.25) // 45 degree

        let cells = cellArray()
        for cell in cells {
            insertCell(cell)
        }

        self.baseView.open(cells)
        setNeedsDisplay()
    }

    // close all cells
    public func close() {
        // rotate plus icon
        self.plusLayer.addAnimation(plusKeyframe(false), forKey: "plusRot")
        self.plusRotation = 0
    
        self.baseView.close(cellArray())
        setNeedsDisplay()
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
        if touching && responsible {
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
    
    // draw button plus or close face
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
                pathPlus(CGFloat(M_PI * 0.125)),
                pathPlus(CGFloat(M_PI * 0)),
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
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        for cell in cellArray() {
            let pointForTargetView = cell.convertPoint(point, fromView: self)
            
            if (CGRectContainsPoint(cell.bounds, pointForTargetView)) {
                if cell.userInteractionEnabled {
                    return cell.hitTest(pointForTargetView, withEvent: event)
                }
            }
        }
        
        return super.hitTest(point, withEvent: event)
    }
    
    // MARK: private methods
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = false

        baseView.setup(self)
        addSubview(baseView)
        
        liquidView.frame = baseView.frame
        liquidView.userInteractionEnabled = false
        addSubview(liquidView)
        
        liquidView.layer.addSublayer(circleLayer)
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
    var opening = false
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

    let openDuration: CGFloat  = 0.6
    let closeDuration: CGFloat = 0.2
    let viscosity: CGFloat     = 0.65

    var baseLiquid: LiquittableCircle?
    var engine:     SimpleCircleLiquidEngine?
    var bigEngine:  SimpleCircleLiquidEngine?

    private var openingCells: [UIView] = []
    private var keyDuration: CGFloat = 0
    private var displayLink: CADisplayLink?

    override func setup(actionButton: LiquidFloatingActionButton) {
        self.frame = actionButton.frame
        self.center = actionButton.center.minus(actionButton.frame.origin)
        let radius = min(self.frame.width, self.frame.height) * 0.5
        self.engine = SimpleCircleLiquidEngine(radiusThresh: radius * 0.73, angleThresh: 0.45)
        engine?.viscosity = viscosity
        self.bigEngine = SimpleCircleLiquidEngine(radiusThresh: radius, angleThresh: 0.55)
        bigEngine?.viscosity = viscosity
        self.engine?.color = actionButton.color
        self.bigEngine?.color = actionButton.color

        baseLiquid = LiquittableCircle(center: self.center.minus(self.frame.origin), radius: radius, color: actionButton.color)
        baseLiquid?.clipsToBounds = false
        baseLiquid?.layer.masksToBounds = false
        
        clipsToBounds = false
        layer.masksToBounds = false
        addSubview(baseLiquid!)
    }

    func open(cells: [UIView]) {
        stop()
        let distance: CGFloat = self.frame.height * 1.25
        displayLink = CADisplayLink(target: self, selector: Selector("didDisplayRefresh:"))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        opening = true
        for cell in cells {
            cell.layer.removeAllAnimations()
            eraseShadow(cell.layer)
            openingCells.append(cell)
        }
    }
    
    func close(cells: [UIView]) {
        stop()
        let distance: CGFloat = self.frame.height * 1.25
        opening = false
        displayLink = CADisplayLink(target: self, selector: Selector("didDisplayRefresh:"))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        for cell in cells {
            cell.layer.removeAllAnimations()
            eraseShadow(cell.layer)
            openingCells.append(cell)
            cell.userInteractionEnabled = false
        }
    }

    func didFinishUpdate() {
        if opening {
            for cell in openingCells {
                cell.userInteractionEnabled = true
            }
        } else {
            for cell in openingCells {
                cell.removeFromSuperview()
            }
        }
    }

    func update(delay: CGFloat, duration: CGFloat, f: (UIView, Int, CGFloat) -> ()) {
        if openingCells.isEmpty {
            return
        }

        let maxDuration = duration + CGFloat(openingCells.count) * CGFloat(delay)
        let t = keyDuration
        let allRatio = easeInEaseOut(t / maxDuration)

        if allRatio >= 1.0 {
            didFinishUpdate()
            stop()
            return
        }

        engine?.clear()
        bigEngine?.clear()
        for i in 0..<openingCells.count {
            if let liquidCell = openingCells[i] as? LiquidFloatingCell {
                let cellDelay = CGFloat(delay) * CGFloat(i)
                let ratio = easeInEaseOut((t - cellDelay) / duration)
                f(liquidCell, i, ratio)
                liquidCell.update(ratio)
            }
        }

        if let firstCell = openingCells[0] as? LiquittableCircle {
            bigEngine?.push(baseLiquid!, other: firstCell)
        }
        for i in 1..<openingCells.count {
            if let prev = openingCells[i - 1] as? LiquittableCircle, cell = openingCells[i] as? LiquittableCircle {
                engine?.push(prev, other: cell)
            }
        }
        engine?.draw(baseLiquid!)
        bigEngine?.draw(baseLiquid!)
    }
    
    func updateOpen() {
        update(0.1, duration: openDuration) { cell, i, ratio in
            let posRatio = ratio > CGFloat(i) / CGFloat(self.openingCells.count) ? ratio : 0
            let distance = (cell.frame.height * 0.5 + CGFloat(i + 1) * cell.frame.height * 1.5) * posRatio
            cell.center = self.center.minusY(distance)
        }
    }
    
    func updateClose() {
        update(0, duration: closeDuration) { cell, i, ratio in
            let distance = (cell.frame.height * 0.5 + CGFloat(i + 1) * cell.frame.height * 1.5) * (1 - ratio)
            cell.center = self.center.minusY(distance)
        }
    }
    
    func stop() {
        for cell in openingCells {
            appendShadow(cell.layer)
        }
        openingCells = []
        keyDuration = 0
        displayLink?.invalidate()
    }
    
    func easeInEaseOut(t: CGFloat) -> CGFloat {
        if t >= 1.0 {
            return 1.0
        }
        if t < 0 {
            return 0
        }
        var t2 = t * 2
        return -1 * t * (t - 2)
    }
    
    func didDisplayRefresh(displayLink: CADisplayLink) {
        if opening {
            keyDuration += CGFloat(displayLink.duration)
            updateOpen()
        } else {
            keyDuration += CGFloat(displayLink.duration)
            updateClose()
        }
    }

}

public class LiquidFloatingCell : LiquittableCircle {
    
    let internalRatio: CGFloat = 0.75

    let callback: () -> ()
    var responsible = true // TODO
    
    public override var frame: CGRect {
        didSet {
            resizeSubviews()
        }
    }

    init(center: CGPoint, radius: CGFloat, color: UIColor, icon: UIImage, callback: () -> ()) {
        self.callback = callback
        super.init(center: center, radius: radius, color: color)
        setup(icon)
    }

    init(center: CGPoint, radius: CGFloat, color: UIColor, view: UIView, callback: () -> ()) {
        self.callback = callback
        super.init(center: center, radius: radius, color: color)
        setupView(view)
    }
    
    public init(icon: UIImage, callback: () -> ()) {
        self.callback = callback
        super.init()
        setup(icon)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, tintColor: UIColor = UIColor.whiteColor()) {
        let imageView = UIImageView()
        imageView.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = tintColor
        setupView(imageView)
    }
    
    func setupView(view: UIView) {
        userInteractionEnabled = false
        addSubview(view)
        resizeSubviews()
    }
    
    private func resizeSubviews() {
        for subview in subviews {
            if let view = subview as? UIView {
                let size = CGSize(width: frame.width * 0.5, height: frame.height * 0.5)
                view.frame = CGRect(x: frame.width - frame.width * internalRatio, y: frame.height - frame.height * internalRatio, width: size.width, height: size.height)
            }
        }
    }
    
    func update(key: CGFloat) {
        for subview in self.subviews {
            if let view = subview as? UIView {
                view.alpha = 2 * (key - 0.5)
            }
        }
    }
    
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if responsible {
            setNeedsDisplay()
        }
    }
    
    public override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        if responsible {
            setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.callback()
    }

}