//
//  ArrayEx.swift
//  Ampdot
//
//  Created by Takuma Yoshida on 2015/06/02.
//  Copyright (c) 2015年 yoavlt All rights reserved.
//

import Foundation

extension Array {
    func each(f: (Element) -> ()) {
        for item in self {
            f(item)
        }
    }
}
