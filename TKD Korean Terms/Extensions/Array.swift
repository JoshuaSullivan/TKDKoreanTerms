//
//  Array.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 8/11/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import Foundation

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
