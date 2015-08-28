//
//  ArrayEx.swift
//  Ampdot
//
//  Created by Takuma Yoshida on 2015/06/02.
//  Copyright (c) 2015年 yoavlt All rights reserved.
//

import Foundation

extension Array {
    func take(n: Int) -> [Element] {
        if self.count == 0 {
            return []
        }
        let size = self.count < n ? self.count : n
        var result: [Element] = []
        for index in 0...size-1 {
            result.append(self[index])
        }
        return result
    }
    
    func each(f: (Element) -> ()) {
        for item in self {
            f(item)
        }
    }
    
    func eachWithIndex(f: (Int, Element) -> ()) {
        if self.count <= 0 {
            return
        }
        for i in 0...self.count-1 {
            f(i, self[i])
        }
    }

    func zip<U>(other: [U]) -> [(Element, U)] {
        var result = [(Element, U)]()
        for (p, q) in Swift.zip(self, other) {
            result.append((p, q))
        }
        return result
    }

    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return Swift.find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
    
    func find (f: (Element) -> Bool) -> Element? {
        for value in self {
            if f(value) {
                return value
            }
        }
        return nil
    }
    
    func mapWithIndex<U>(f: (Int, Element) -> U) -> [U] {
        if self.isEmpty {
            return []
        }
        var elements: [U] = []
        for i in 0...self.count-1 {
            let item = self[i]
            let newItem = f(i, item)
            elements.append(newItem)
        }
        return elements
    }
    
    func without<U: Equatable>(target: U) -> [U] {
        var results: [U] = []
        for item in self {
            if item as! U != target {
                results.append(item as! U)
            }
        }
        return results
    }
    
    func at(index: Int) -> Element? {
        if index >= 0 && count > index {
            return self[index]
        }
        return nil
    }
    
    func flatten<U>() -> [U] {
        var res: [U] = []
        for array in self {
            if let arr = array as? [U] {
                for item in arr {
                    res.append(item)
                }
            }
        }
        return res
    }
    
    func concat<U>(array: [U]) -> [U] {
        var result: [U] = []
        for item in array {
            result.append(item)
        }
        for item in self {
            if let elem = item as? U {
                result.append(elem)
            }
        }
        return result
    }
    
}
