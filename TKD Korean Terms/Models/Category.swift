//
//  Category.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 2/14/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import Foundation

struct Category {
    let name: String
    let terms: [Term]
    
    init?(dict: DataDictionary) {
        guard let
            name = dict["category"] as? String,
            termArr = dict["terms"] as? [DataDictionary]
            else {
                assertionFailure("Couldn't find all required properties.")
                return nil
        }
        self.name = name
        self.terms = termArr.flatMap{ Term(dict:$0) }
    }
}
