//
//  SnapKit
//
//  Copyright (c) 2011-2015 SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

/**
    Used to expose the final API of a `ConstraintDescription` which allows getting a constraint from it
 */
public protocol ConstraintDescriptionFinalizable: class {
    
    var constraint: Constraint { get }
    
    func labeled(_ label: String) -> ConstraintDescriptionFinalizable
    
}

/**
    Used to expose priority APIs
 */
public protocol ConstraintDescriptionPriortizable: ConstraintDescriptionFinalizable {
    
    func priority(_ priority: Float) -> ConstraintDescriptionFinalizable
    func priority(_ priority: Double) -> ConstraintDescriptionFinalizable
    func priority(_ priority: CGFloat) -> ConstraintDescriptionFinalizable
    func priority(_ priority: UInt) -> ConstraintDescriptionFinalizable
    func priority(_ priority: Int) -> ConstraintDescriptionFinalizable
    func priorityRequired() -> ConstraintDescriptionFinalizable
    func priorityHigh() -> ConstraintDescriptionFinalizable
    func priorityMedium() -> ConstraintDescriptionFinalizable
    func priorityLow() -> ConstraintDescriptionFinalizable
}

/**
    Used to expose multiplier & constant APIs
*/
public protocol ConstraintDescriptionEditable: ConstraintDescriptionPriortizable {

    func multipliedBy(_ amount: Float) -> ConstraintDescriptionEditable
    func multipliedBy(_ amount: Double) -> ConstraintDescriptionEditable
    func multipliedBy(_ amount: CGFloat) -> ConstraintDescriptionEditable
    func multipliedBy(_ amount: Int) -> ConstraintDescriptionEditable
    func multipliedBy(_ amount: UInt) -> ConstraintDescriptionEditable
    
    func dividedBy(_ amount: Float) -> ConstraintDescriptionEditable
    func dividedBy(_ amount: Double) -> ConstraintDescriptionEditable
    func dividedBy(_ amount: CGFloat) -> ConstraintDescriptionEditable
    func dividedBy(_ amount: Int) -> ConstraintDescriptionEditable
    func dividedBy(_ amount: UInt) -> ConstraintDescriptionEditable

    func offset(_ amount: Float) -> ConstraintDescriptionEditable
    func offset(_ amount: Double) -> ConstraintDescriptionEditable
    func offset(_ amount: CGFloat) -> ConstraintDescriptionEditable
    func offset(_ amount: Int) -> ConstraintDescriptionEditable
    func offset(_ amount: UInt) -> ConstraintDescriptionEditable
    func offset(_ amount: CGPoint) -> ConstraintDescriptionEditable
    func offset(_ amount: CGSize) -> ConstraintDescriptionEditable
    func offset(_ amount: EdgeInsets) -> ConstraintDescriptionEditable
    
    func inset(_ amount: Float) -> ConstraintDescriptionEditable
    func inset(_ amount: Double) -> ConstraintDescriptionEditable
    func inset(_ amount: CGFloat) -> ConstraintDescriptionEditable
    func inset(_ amount: Int) -> ConstraintDescriptionEditable
    func inset(_ amount: UInt) -> ConstraintDescriptionEditable
    func inset(_ amount: EdgeInsets) -> ConstraintDescriptionEditable
}

/**
    Used to expose relation APIs
*/
public protocol ConstraintDescriptionRelatable: class {
    
    func equalTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable
    func equalTo(_ other: View) -> ConstraintDescriptionEditable
    func equalToSuperview() -> ConstraintDescriptionEditable
    @available(iOS 7.0, *)
    func equalTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable
    @available(iOS 9.0, OSX 10.11, *)
    func equalTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable
    func equalTo(_ other: Float) -> ConstraintDescriptionEditable
    func equalTo(_ other: Double) -> ConstraintDescriptionEditable
    func equalTo(_ other: CGFloat) -> ConstraintDescriptionEditable
    func equalTo(_ other: Int) -> ConstraintDescriptionEditable
    func equalTo(_ other: UInt) -> ConstraintDescriptionEditable
    func equalTo(_ other: CGSize) -> ConstraintDescriptionEditable
    func equalTo(_ other: CGPoint) -> ConstraintDescriptionEditable
    func equalTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable
    
    func lessThanOrEqualTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: View) -> ConstraintDescriptionEditable
    func lessThanOrEqualToSuperview() -> ConstraintDescriptionEditable
    @available(iOS 7.0, *)
    func lessThanOrEqualTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable
    @available(iOS 9.0, OSX 10.11, *)
    func lessThanOrEqualTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: Float) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: Double) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: CGFloat) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: Int) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: UInt) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: CGSize) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: CGPoint) -> ConstraintDescriptionEditable
    func lessThanOrEqualTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable
    
    func greaterThanOrEqualTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: View) -> ConstraintDescriptionEditable
    func greaterThanOrEqualToSuperview() -> ConstraintDescriptionEditable
    @available(iOS 7.0, *)
    func greaterThanOrEqualTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable
    @available(iOS 9.0, OSX 10.11, *)
    func greaterThanOrEqualTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: Float) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: Double) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: CGFloat) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: Int) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: UInt) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: CGSize) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: CGPoint) -> ConstraintDescriptionEditable
    func greaterThanOrEqualTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable

}

/**
    Used to expose chaining APIs
*/
public protocol ConstraintDescriptionExtendable: ConstraintDescriptionRelatable {
    
    var left: ConstraintDescriptionExtendable { get }
    var top: ConstraintDescriptionExtendable { get }
    var bottom: ConstraintDescriptionExtendable { get }
    var right: ConstraintDescriptionExtendable { get }
    var leading: ConstraintDescriptionExtendable { get }
    var trailing: ConstraintDescriptionExtendable { get }
    var width: ConstraintDescriptionExtendable { get }
    var height: ConstraintDescriptionExtendable { get }
    var centerX: ConstraintDescriptionExtendable { get }
    var centerY: ConstraintDescriptionExtendable { get }
    var baseline: ConstraintDescriptionExtendable { get }
    
    @available(iOS 8.0, *)
    var firstBaseline: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var leftMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var rightMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var topMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var bottomMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var leadingMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var trailingMargin: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var centerXWithinMargins: ConstraintDescriptionExtendable { get }
    @available(iOS 8.0, *)
    var centerYWithinMargins: ConstraintDescriptionExtendable { get }
}

/**
    Used to internally manage building constraint
 */
internal class ConstraintDescription: ConstraintDescriptionExtendable, ConstraintDescriptionEditable, ConstraintDescriptionFinalizable {
    
    internal var left: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Left) }
    internal var top: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Top) }
    internal var right: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Right) }
    internal var bottom: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Bottom) }
    internal var leading: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Leading) }
    internal var trailing: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Trailing) }
    internal var width: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Width) }
    internal var height: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Height) }
    internal var centerX: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.CenterX) }
    internal var centerY: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.CenterY) }
    internal var baseline: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.Baseline) }
    internal var label: String?
    
    @available(iOS 8.0, *)
    internal var firstBaseline: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.FirstBaseline) }
    @available(iOS 8.0, *)
    internal var leftMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.LeftMargin) }
    @available(iOS 8.0, *)
    internal var rightMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.RightMargin) }
    @available(iOS 8.0, *)
    internal var topMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.TopMargin) }
    @available(iOS 8.0, *)
    internal var bottomMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.BottomMargin) }
    @available(iOS 8.0, *)
    internal var leadingMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.LeadingMargin) }
    @available(iOS 8.0, *)
    internal var trailingMargin: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.TrailingMargin) }
    @available(iOS 8.0, *)
    internal var centerXWithinMargins: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.CenterXWithinMargins) }
    @available(iOS 8.0, *)
    internal var centerYWithinMargins: ConstraintDescriptionExtendable { return self.addConstraint(ConstraintAttributes.CenterYWithinMargins) }
    
    // MARK: initializer
    
    init(fromItem: ConstraintItem) {
        self.fromItem = fromItem
        self.toItem = ConstraintItem(object: nil, attributes: ConstraintAttributes.None)
    }
    
    // MARK: equalTo
    
    internal func equalTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalTo(_ other: View) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalToSuperview() -> ConstraintDescriptionEditable {
        guard let superview = fromItem.view?.superview else {
            fatalError("equalToSuperview() requires the view have a superview before being set.")
        }
        
        return self.equalTo(superview)
    }
    @available(iOS 7.0, *)
    internal func equalTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    @available(iOS 9.0, OSX 10.11, *)
    internal func equalTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalTo(_ other: Float) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalTo(_ other: Double) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .equal)
    }
    internal func equalTo(_ other: CGFloat) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .equal)
    }
    internal func equalTo(_ other: Int) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .equal)
    }
    internal func equalTo(_ other: UInt) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .equal)
    }
    internal func equalTo(_ other: CGSize) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalTo(_ other: CGPoint) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    internal func equalTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .equal)
    }
    
    // MARK: lessThanOrEqualTo
    
    internal func lessThanOrEqualTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: View) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualToSuperview() -> ConstraintDescriptionEditable {
        guard let superview = fromItem.view?.superview else {
            fatalError("lessThanOrEqualToSuperview() requires the view have a superview before being set.")
        }
        
        return self.lessThanOrEqualTo(superview)
    }
    @available(iOS 7.0, *)
    internal func lessThanOrEqualTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    @available(iOS 9.0, OSX 10.11, *)
    internal func lessThanOrEqualTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: Float) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: Double) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: CGFloat) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: Int) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: UInt) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: CGSize) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: CGPoint) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func lessThanOrEqualTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    
    // MARK: greaterThanOrEqualTo
    
    internal func greaterThanOrEqualTo(_ other: ConstraintItem) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: View) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualToSuperview() ->  ConstraintDescriptionEditable {
        guard let superview = fromItem.view?.superview else {
            fatalError("greaterThanOrEqualToSuperview() requires the view have a superview before being set.")
        }
        
        return self.greaterThanOrEqualTo(superview)
    }
    @available(iOS 7.0, *)
    internal func greaterThanOrEqualTo(_ other: LayoutSupport) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    @available(iOS 9.0, OSX 10.11, *)
    internal func greaterThanOrEqualTo(other: NSLayoutAnchor<AnyObject>) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .lessThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: Float) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: Double) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: CGFloat) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: Int) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: UInt) -> ConstraintDescriptionEditable {
        return self.constrainTo(Float(other), relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: CGSize) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: CGPoint) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    internal func greaterThanOrEqualTo(_ other: EdgeInsets) -> ConstraintDescriptionEditable {
        return self.constrainTo(other, relation: .greaterThanOrEqualTo)
    }
    
    // MARK: multiplier
    
    internal func multipliedBy(_ amount: Float) -> ConstraintDescriptionEditable {
        self.multiplier = amount
        return self
    }
    internal func multipliedBy(_ amount: Double) -> ConstraintDescriptionEditable {
        return self.multipliedBy(Float(amount))
    }
    internal func multipliedBy(_ amount: CGFloat) -> ConstraintDescriptionEditable {
        return self.multipliedBy(Float(amount))
    }
    internal func multipliedBy(_ amount: Int) -> ConstraintDescriptionEditable {
        return self.multipliedBy(Float(amount))
    }
    internal func multipliedBy(_ amount: UInt) -> ConstraintDescriptionEditable {
        return self.multipliedBy(Float(amount))
    }
    
    internal func dividedBy(_ amount: Float) -> ConstraintDescriptionEditable {
        self.multiplier = 1.0 / amount;
        return self
    }
    internal func dividedBy(_ amount: Double) -> ConstraintDescriptionEditable {
        return self.dividedBy(Float(amount))
    }
    internal func dividedBy(_ amount: CGFloat) -> ConstraintDescriptionEditable {
        return self.dividedBy(Float(amount))
    }
    internal func dividedBy(_ amount: Int) -> ConstraintDescriptionEditable {
        return self.dividedBy(Float(amount))
    }
    internal func dividedBy(_ amount: UInt) -> ConstraintDescriptionEditable {
        return self.dividedBy(Float(amount))
    }
    
    // MARK: offset
    
    internal func offset(_ amount: Float) -> ConstraintDescriptionEditable {
        self.constant = amount
        return self
    }
    internal func offset(_ amount: Double) -> ConstraintDescriptionEditable {
        return self.offset(Float(amount))
    }
    internal func offset(_ amount: CGFloat) -> ConstraintDescriptionEditable {
        return self.offset(Float(amount))
    }
    internal func offset(_ amount: Int) -> ConstraintDescriptionEditable {
        return self.offset(Float(amount))
    }
    internal func offset(_ amount: UInt) -> ConstraintDescriptionEditable {
        return self.offset(Float(amount))
    }
    internal func offset(_ amount: CGPoint) -> ConstraintDescriptionEditable {
        self.constant = amount
        return self
    }
    internal func offset(_ amount: CGSize) -> ConstraintDescriptionEditable {
        self.constant = amount
        return self
    }
    internal func offset(_ amount: EdgeInsets) -> ConstraintDescriptionEditable {
        self.constant = amount
        return self
    }
    
    // MARK: inset
    
    internal func inset(_ amount: Float) -> ConstraintDescriptionEditable {
        let value = CGFloat(amount)
        self.constant = EdgeInsets(top: value, left: value, bottom: -value, right: -value)
        return self
    }
    internal func inset(_ amount: Double) -> ConstraintDescriptionEditable {
        let value = CGFloat(amount)
        self.constant = EdgeInsets(top: value, left: value, bottom: -value, right: -value)
        return self
    }
    internal func inset(_ amount: CGFloat) -> ConstraintDescriptionEditable {
        self.constant = EdgeInsets(top: amount, left: amount, bottom: -amount, right: -amount)
        return self
    }
    internal func inset(_ amount: Int) -> ConstraintDescriptionEditable {
        let value = CGFloat(amount)
        self.constant = EdgeInsets(top: value, left: value, bottom: -value, right: -value)
        return self
    }
    internal func inset(_ amount: UInt) -> ConstraintDescriptionEditable {
        let value = CGFloat(amount)
        self.constant = EdgeInsets(top: value, left: value, bottom: -value, right: -value)
        return self
    }
    internal func inset(_ amount: EdgeInsets) -> ConstraintDescriptionEditable {
        self.constant = EdgeInsets(top: amount.top, left: amount.left, bottom: -amount.bottom, right: -amount.right)
        return self
    }
    
    // MARK: priority
    
    internal func priority(_ priority: Float) -> ConstraintDescriptionFinalizable {
        self.priority = priority
        return self
    }
    internal func priority(_ priority: Double) -> ConstraintDescriptionFinalizable {
        return self.priority(Float(priority))
    }
    internal func priority(_ priority: CGFloat) -> ConstraintDescriptionFinalizable {
        return self.priority(Float(priority))
    }
    func priority(_ priority: UInt) -> ConstraintDescriptionFinalizable {
        return self.priority(Float(priority))
    }
    internal func priority(_ priority: Int) -> ConstraintDescriptionFinalizable {
        return self.priority(Float(priority))
    }
    internal func priorityRequired() -> ConstraintDescriptionFinalizable {
        return self.priority(1000.0)
    }
    internal func priorityHigh() -> ConstraintDescriptionFinalizable {
        return self.priority(750.0)
    }
    internal func priorityMedium() -> ConstraintDescriptionFinalizable {
        #if os(iOS) || os(tvOS)
        return self.priority(500.0)
        #else
        return self.priority(501.0)
        #endif
    }
    internal func priorityLow() -> ConstraintDescriptionFinalizable {
        return self.priority(250.0)
    }
    
    // MARK: Constraint
    
    internal var constraint: Constraint {
        if self.concreteConstraint == nil {
            if self.relation == nil {
                fatalError("Attempting to create a constraint from a ConstraintDescription before it has been fully chained.")
            }
            self.concreteConstraint = ConcreteConstraint(
                fromItem: self.fromItem,
                toItem: self.toItem,
                relation: self.relation!,
                constant: self.constant,
                multiplier: self.multiplier,
                priority: self.priority,
                label: self.label)
        }
        return self.concreteConstraint!
    }
    
    func labeled(_ label: String) -> ConstraintDescriptionFinalizable {
        self.label = label
        return self
    }
    
    // MARK: Private
    
    fileprivate let fromItem: ConstraintItem
    fileprivate var toItem: ConstraintItem {
        willSet {
            if self.concreteConstraint != nil {
                fatalError("Attempting to modify a ConstraintDescription after its constraint has been created.")
            }
        }
    }
    fileprivate var relation: ConstraintRelation? {
        willSet {
            if self.concreteConstraint != nil {
                fatalError("Attempting to modify a ConstraintDescription after its constraint has been created.")
            }
        }
    }
    fileprivate var constant: Any = Float(0.0) {
        willSet {
            if self.concreteConstraint != nil {
                fatalError("Attempting to modify a ConstraintDescription after its constraint has been created.")
            }
        }
    }
    fileprivate var multiplier: Float = 1.0 {
        willSet {
            if self.concreteConstraint != nil {
                fatalError("Attempting to modify a ConstraintDescription after its constraint has been created.")
            }
        }
    }
    fileprivate var priority: Float = 1000.0 {
        willSet {
            if self.concreteConstraint != nil {
                fatalError("Attempting to modify a ConstraintDescription after its constraint has been created.")
            }
        }
    }
    fileprivate var concreteConstraint: ConcreteConstraint? = nil
    
    fileprivate func addConstraint(_ attributes: ConstraintAttributes) -> ConstraintDescription {
        if self.relation == nil {
            self.fromItem.attributes += attributes
        }
        return self
    }
    
    fileprivate func constrainTo(_ other: ConstraintItem, relation: ConstraintRelation) -> ConstraintDescription {
        if other.attributes != ConstraintAttributes.None {
            let toLayoutAttributes = other.attributes.layoutAttributes
            if toLayoutAttributes.count > 1 {
                let fromLayoutAttributes = self.fromItem.attributes.layoutAttributes
                if toLayoutAttributes != fromLayoutAttributes {
                    NSException(name: NSExceptionName(rawValue: "Invalid Constraint"), reason: "Cannot constrain to multiple non identical attributes", userInfo: nil).raise()
                    return self
                }
                other.attributes = ConstraintAttributes.None
            }
        }
        self.toItem = other
        self.relation = relation
        return self
    }
    
    fileprivate func constrainTo(_ other: View, relation: ConstraintRelation) -> ConstraintDescription {
        return constrainTo(ConstraintItem(object: other, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    @available(iOS 7.0, *)
    fileprivate func constrainTo(_ other: LayoutSupport, relation: ConstraintRelation) -> ConstraintDescription {
        return constrainTo(ConstraintItem(object: other, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    @available(iOS 9.0, OSX 10.11, *)
    fileprivate func constrainTo(_ other: NSLayoutAnchor<AnyObject>, relation: ConstraintRelation) -> ConstraintDescription {
        return constrainTo(ConstraintItem(object: other, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    fileprivate func constrainTo(_ other: Float, relation: ConstraintRelation) -> ConstraintDescription {
        self.constant = other
        return constrainTo(ConstraintItem(object: nil, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    fileprivate func constrainTo(_ other: Double, relation: ConstraintRelation) -> ConstraintDescription {
        self.constant = other
        return constrainTo(ConstraintItem(object: nil, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    fileprivate func constrainTo(_ other: CGSize, relation: ConstraintRelation) -> ConstraintDescription {
        self.constant = other
        return constrainTo(ConstraintItem(object: nil, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    fileprivate func constrainTo(_ other: CGPoint, relation: ConstraintRelation) -> ConstraintDescription {
        self.constant = other
        return constrainTo(ConstraintItem(object: nil, attributes: ConstraintAttributes.None), relation: relation)
    }
    
    fileprivate func constrainTo(_ other: EdgeInsets, relation: ConstraintRelation) -> ConstraintDescription {
        self.constant = other
        return constrainTo(ConstraintItem(object: nil, attributes: ConstraintAttributes.None), relation: relation)
    }
}
