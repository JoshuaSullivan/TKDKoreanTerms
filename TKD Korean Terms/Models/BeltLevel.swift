//
//  BeltLevel.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 2/14/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import Foundation

struct BeltLevel{
    let icon: String
    let level: Int
    let name: String
    let beltName: String
    let categories: [Category]?
    
    init?(dict: DataDictionary) {
        guard let
            icon = dict["icon"] as? String,
            level = dict["level"] as? Int,
            name = dict["name"] as? String,
            beltName = dict["beltLevel"] as? String
            else {
                assertionFailure("Couldn't find all required properties.")
                return nil
        }
        self.icon = icon
        self.level = level
        self.name = name
        self.beltName = beltName
        if let catArr = dict["categories"] as? [DataDictionary] {
            self.categories = catArr.flatMap{ Category(dict:$0) }
        } else {
            self.categories = nil
        }
    }
}
