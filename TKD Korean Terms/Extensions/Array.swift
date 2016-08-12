//
//  Array.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 8/11/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import Foundation

func shuffle<C: MutableCollectionType where C.Index == Int>(inout list: C) {
    let c = list.count
    for i in 0..<(c - 1) {
        let j = Int(arc4random_uniform(UInt32(c - i))) + i
        swap(&list[i], &list[j])
    }
}

/// Return a collection containing the shuffled elements of `list`.
func shuffled<C: MutableCollectionType where C.Index == Int>(list: C) -> C {
    var copy = list
    shuffle(&copy)
    return copy
}

extension Array {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i - 1))) + i + 1
            swap(&self[i], &self[j])
        }
    }
    
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Element] {
        var list = self
        list.shuffle()
        return list
    }
    
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}