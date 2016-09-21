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
    Used to allow adding a snp_label to a View for debugging purposes
*/
public extension View {
    
    public var snp_label: String? {
        get {
            return objc_getAssociatedObject(self, &labelKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &labelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}

/**
    Used to allow adding a snp_label to a LayoutConstraint for debugging purposes
*/
public extension LayoutConstraint {
    
    public var snp_label: String? {
        get {
            return objc_getAssociatedObject(self, &labelKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &labelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    override open var description: String {
        var description = "<"
        
        description += descriptionForObject(self)
        
        description += " \(descriptionForObject(self.firstItem))"
        if self.firstAttribute != .notAnAttribute {
            description += ".\(self.firstAttribute.snp_description)"
        }
        
        description += " \(self.relation.snp_description)"
        
        if let secondItem: AnyObject = self.secondItem {
            description += " \(descriptionForObject(secondItem))"
        }
        
        if self.secondAttribute != .notAnAttribute {
            description += ".\(self.secondAttribute.snp_description)"
        }
        
        if self.multiplier != 1.0 {
            description += " * \(self.multiplier)"
        }
        
        if self.secondAttribute == .notAnAttribute {
            description += " \(self.constant)"
        } else {
            if self.constant > 0.0 {
                description += " + \(self.constant)"
            } else if self.constant < 0.0 {
                description += " - \(abs(self.constant))"
            }
        }
        
        if self.priority != 1000.0 {
            description += " ^\(self.priority)"
        }
        
        description += ">"
        
        return description
    }
    
    internal var snp_makerFile: String? {
        return self.snp_constraint?.makerFile
    }
    
    internal var snp_makerLine: UInt? {
        return self.snp_constraint?.makerLine
    }
    
}

private var labelKey = ""

private func descriptionForObject(_ object: AnyObject) -> String {
    let pointerDescription = NSString(format: "%p", UInt(bitPattern: ObjectIdentifier(object)))
    var desc = ""
    
    desc += type(of: object).description()
    
    if let object = object as? View {
        desc += ":\(object.snp_label ?? pointerDescription as String)"
    } else if let object = object as? LayoutConstraint {
        desc += ":\(object.snp_label ?? pointerDescription as String)"
    } else {
        desc += ":\(pointerDescription)"
    }
    
    if let object = object as? LayoutConstraint, let file = object.snp_makerFile, let line = object.snp_makerLine {
        desc += "@\(file)#\(line)"
    }
    
    desc += ""
    return desc
}

private extension NSLayoutRelation {
    
    var snp_description: String {
        switch self {
        case .equal:                return "=="
        case .greaterThanOrEqual:   return ">="
        case .lessThanOrEqual:      return "<="
        }
    }
    
}

private extension NSLayoutAttribute {
    
    var snp_description: String {
        #if os(iOS) || os(tvOS)
        switch self {
        case .notAnAttribute:       return "notAnAttribute"
        case .top:                  return "top"
        case .left:                 return "left"
        case .bottom:               return "bottom"
        case .right:                return "right"
        case .leading:              return "leading"
        case .trailing:             return "trailing"
        case .width:                return "width"
        case .height:               return "height"
        case .centerX:              return "centerX"
        case .centerY:              return "centerY"
        case .lastBaseline:             return "baseline"
        case .firstBaseline:        return "firstBaseline"
        case .topMargin:            return "topMargin"
        case .leftMargin:           return "leftMargin"
        case .bottomMargin:         return "bottomMargin"
        case .rightMargin:          return "rightMargin"
        case .leadingMargin:        return "leadingMargin"
        case .trailingMargin:       return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        }
        #else
        switch self {
        case .NotAnAttribute:       return "notAnAttribute"
        case .Top:                  return "top"
        case .Left:                 return "left"
        case .Bottom:               return "bottom"
        case .Right:                return "right"
        case .Leading:              return "leading"
        case .Trailing:             return "trailing"
        case .Width:                return "width"
        case .Height:               return "height"
        case .CenterX:              return "centerX"
        case .CenterY:              return "centerY"
        case .Baseline:             return "baseline"
        default:                    return "default"
        }
        #endif
        
    }
    
}
