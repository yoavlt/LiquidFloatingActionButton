//
//  UIColorEx.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/21.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var redChannel: CGFloat {
        get {
            let components = self.cgColor.components
            return components![0]
        }
    }
    
    var greenChannel: CGFloat {
        get {
            let components = self.cgColor.components
            return components![1]
        }
    }
    
    var blueChannel: CGFloat {
        get {
            let components = self.cgColor.components
            return components![2]
        }
    }
    
    var alphaChannel: CGFloat {
        get {
            return self.cgColor.alpha
        }
    }

    func alpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: self.redChannel, green: self.greenChannel, blue: self.blueChannel, alpha: alpha)
    }
    
    func white(_ scale: CGFloat) -> UIColor {
        return UIColor(
            red: self.redChannel + (1.0 - self.redChannel) * scale,
            green: self.greenChannel + (1.0 - self.greenChannel) * scale,
            blue: self.blueChannel + (1.0 - self.blueChannel) * scale,
            alpha: 1.0
        )
    }
}
