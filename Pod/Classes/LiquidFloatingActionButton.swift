//
//  LiquidFloatingActionButton.swift
//  Pods
//
//  Created by Takuma Yoshida on 2015/08/25.
//
//

import Foundation
import QuartzCore

// LiquidFloatingButton DataSource methods
@objc public protocol LiquidFloatingActionButtonDataSource {
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int
    func cellForIndex(index: Int) -> LiquidFloatingCell
}

@objc public protocol LiquidFloatingActionButtonDelegate {
    // selected method
    optional func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int)
}

public enum LiquidFloatingActionButtonAnimateStyle : Int {
    case Up
    case Right
    case Left
    case Down
}

@IBDesignable
public class LiquidFloatingActionButton : UIView {

    private let internalRadiusRatio: CGFloat = 20.0 / 56.0
    public var cellRadiusRatio: CGFloat      = 0.38
    public var animateStyle: LiquidFloatingActionButtonAnimateStyle = .Up {
        didSet {
            baseView.animateStyle = animateStyle
        }
    }
    public var enableShadow = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var delegate:   LiquidFloatingActionButtonDelegate?
    public var dataSource: LiquidFloatingActionButtonDataSource?

    public var responsible = true
    public var isOpening: Bool  {
        get {
            return !baseView.openingCells.isEmpty
        }
    }
    public private(set) var isClosed: Bool = true
    
    @IBInspectable public var color: UIColor = UIColor(red: 82 / 255.0, green: 112 / 255.0, blue: 235 / 255.0, alpha: 1.0) {
        didSet {
            baseView.color = color
        }
    }
    
    @IBInspectable public var image: UIImage? {
        didSet {
            if image != nil {
                plusLayer.contents = image!.CGImage
                plusLayer.path = nil
            }
        }
    }
    
    @IBInspectable public var rotationDegrees: CGFloat = 45.0

    private var plusLayer   = CAShapeLayer()
    private let circleLayer = CAShapeLayer()
    
    private var touching = false

    private var baseView = CircleLiquidBaseView()
    private let liquidView = UIView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func insertCell(cell: LiquidFloatingCell) {
        cell.color  = self.color
        cell.radius = self.frame.width * cellRadiusRatio
        cell.center = self.center.minus(self.frame.origin)
        cell.actionButton = self
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
        CATransaction.setAnimationDuration(0.8)
        self.plusLayer.transform = CATransform3DMakeRotation((CGFloat(M_PI) * rotationDegrees) / 180, 0, 0, 1)

        let cells = cellArray()
        for cell in cells {
            insertCell(cell)
        }

        self.baseView.open(cells)
        
        self.isClosed = false
    }

    // close all cells
    public func close() {
        
        // rotate plus icon
        CATransaction.setAnimationDuration(0.8)
        self.plusLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
    
        self.baseView.close(cellArray())
        
        self.isClosed = true
    }

    // MARK: draw icon
    public override func drawRect(rect: CGRect) {
        drawCircle()
        drawShadow()
    }
    
    /// create, configure & draw the plus layer (override and create your own shape in subclass!)
    public func createPlusLayer(frame: CGRect) -> CAShapeLayer {
        
        // draw plus shape
        let plusLayer = CAShapeLayer()
        plusLayer.lineCap = kCALineCapRound
        plusLayer.strokeColor = UIColor.whiteColor().CGColor
        plusLayer.lineWidth = 3.0
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: frame.width * internalRadiusRatio, y: frame.height * 0.5))
        path.addLineToPoint(CGPoint(x: frame.width * (1 - internalRadiusRatio), y: frame.height * 0.5))
        path.moveToPoint(CGPoint(x: frame.width * 0.5, y: frame.height * internalRadiusRatio))
        path.addLineToPoint(CGPoint(x: frame.width * 0.5, y: frame.height * (1 - internalRadiusRatio)))
        
        plusLayer.path = path.CGPath
        return plusLayer
    }
    
    private func drawCircle() {
        self.circleLayer.cornerRadius = self.frame.width * 0.5
        self.circleLayer.masksToBounds = true
        if touching && responsible {
            self.circleLayer.backgroundColor = self.color.white(0.5).CGColor
        } else {
            self.circleLayer.backgroundColor = self.color.CGColor
        }
    }
    
    private func drawShadow() {
        if enableShadow {
            circleLayer.appendShadow()
        }
    }
    
    // MARK: Events
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touching = true
        setNeedsDisplay()
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touching = false
        setNeedsDisplay()
        didTapped()
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
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
        circleLayer.frame = liquidView.layer.bounds
        
        plusLayer = createPlusLayer(circleLayer.bounds)
        circleLayer.addSublayer(plusLayer)
        plusLayer.frame = circleLayer.bounds
    }

    private func didTapped() {
        if isClosed {
            open()
        } else {
            close()
        }
    }
    
    public func didTappedCell(target: LiquidFloatingCell) {
        if let _ = dataSource {
            let cells = cellArray()
            for i in 0..<cells.count {
                let cell = cells[i]
                if target === cell {
                    delegate?.liquidFloatingActionButton?(self, didSelectItemAtIndex: i)
                }
            }
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
    var animateStyle: LiquidFloatingActionButtonAnimateStyle = .Up
    var color: UIColor = UIColor(red: 82 / 255.0, green: 112 / 255.0, blue: 235 / 255.0, alpha: 1.0) {
        didSet {
            engine?.color = color
            bigEngine?.color = color
        }
    }

    var baseLiquid: LiquittableCircle?
    var engine:     SimpleCircleLiquidEngine?
    var bigEngine:  SimpleCircleLiquidEngine?
    var enableShadow = true

    private var openingCells: [LiquidFloatingCell] = []
    private var keyDuration: CGFloat = 0
    private var displayLink: CADisplayLink?

    override func setup(actionButton: LiquidFloatingActionButton) {
        self.frame = actionButton.frame
        self.center = actionButton.center.minus(actionButton.frame.origin)
        self.animateStyle = actionButton.animateStyle
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

    func open(cells: [LiquidFloatingCell]) {
        stop()
        displayLink = CADisplayLink(target: self, selector: #selector(CircleLiquidBaseView.didDisplayRefresh(_:)))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        opening = true
        for cell in cells {
            cell.layer.removeAllAnimations()
            cell.layer.eraseShadow()
            openingCells.append(cell)
        }
    }
    
    func close(cells: [LiquidFloatingCell]) {
        stop()
        opening = false
        displayLink = CADisplayLink(target: self, selector: #selector(CircleLiquidBaseView.didDisplayRefresh(_:)))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        for cell in cells {
            cell.layer.removeAllAnimations()
            cell.layer.eraseShadow()
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

    func update(delay: CGFloat, duration: CGFloat, f: (LiquidFloatingCell, Int, CGFloat) -> ()) {
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
            let liquidCell = openingCells[i]
            let cellDelay = CGFloat(delay) * CGFloat(i)
            let ratio = easeInEaseOut((t - cellDelay) / duration)
            f(liquidCell, i, ratio)
        }

        if let firstCell = openingCells.first {
            bigEngine?.push(baseLiquid!, other: firstCell)
        }
        for i in 1..<openingCells.count {
            let prev = openingCells[i - 1]
            let cell = openingCells[i]
            engine?.push(prev, other: cell)
        }
        engine?.draw(baseLiquid!)
        bigEngine?.draw(baseLiquid!)
    }
    
    func updateOpen() {
        update(0.1, duration: openDuration) { cell, i, ratio in
            let posRatio = ratio > CGFloat(i) / CGFloat(self.openingCells.count) ? ratio : 0
            let distance = (cell.frame.height * 0.5 + CGFloat(i + 1) * cell.frame.height * 1.5) * posRatio
            cell.center = self.center.plus(self.differencePoint(distance))
            cell.update(ratio, open: true)
        }
    }
    
    func updateClose() {
        update(0, duration: closeDuration) { cell, i, ratio in
            let distance = (cell.frame.height * 0.5 + CGFloat(i + 1) * cell.frame.height * 1.5) * (1 - ratio)
            cell.center = self.center.plus(self.differencePoint(distance))
            cell.update(ratio, open: false)
        }
    }
    
    func differencePoint(distance: CGFloat) -> CGPoint {
        switch animateStyle {
        case .Up:
            return CGPoint(x: 0, y: -distance)
        case .Right:
            return CGPoint(x: distance, y: 0)
        case .Left:
            return CGPoint(x: -distance, y: 0)
        case .Down:
            return CGPoint(x: 0, y: distance)
        }
    }
    
    func stop() {
        for cell in openingCells {
            if enableShadow {
                cell.layer.appendShadow()
            }
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

    public var responsible = true
    public var imageView = UIImageView()
    weak var actionButton: LiquidFloatingActionButton?

    // for implement responsible color
    private var originalColor: UIColor
    
    public override var frame: CGRect {
        didSet {
            resizeSubviews()
        }
    }

    init(center: CGPoint, radius: CGFloat, color: UIColor, icon: UIImage) {
        self.originalColor = color
        super.init(center: center, radius: radius, color: color)
        setup(icon)
    }

    init(center: CGPoint, radius: CGFloat, color: UIColor, view: UIView) {
        self.originalColor = color
        super.init(center: center, radius: radius, color: color)
        setupView(view)
    }
    
    public init(icon: UIImage) {
        self.originalColor = UIColor.clearColor()
        super.init()
        setup(icon)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, tintColor: UIColor = UIColor.whiteColor()) {
        imageView.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = tintColor
        setupView(imageView)
    }
    
    public func setupView(view: UIView) {
        userInteractionEnabled = false
        addSubview(view)
        resizeSubviews()
    }
    
    private func resizeSubviews() {
        let size = CGSize(width: frame.width * 0.5, height: frame.height * 0.5)
        imageView.frame = CGRect(x: frame.width - frame.width * internalRatio, y: frame.height - frame.height * internalRatio, width: size.width, height: size.height)
    }
    
    func update(key: CGFloat, open: Bool) {
        for subview in self.subviews {
            let ratio = max(2 * (key * key - 0.5), 0)
            subview.alpha = open ? ratio : -ratio
        }
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if responsible {
            originalColor = color
            color = originalColor.white(0.5)
            setNeedsDisplay()
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if responsible {
            color = originalColor
            setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        color = originalColor
        actionButton?.didTappedCell(self)
    }

}