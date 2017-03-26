//
//  Term.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 2/14/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import Foundation

struct Term {
    
    let korean: String
    let english: String
    
    init?(dict: DataDictionary) {
        guard let
        korean = dict["kr"] as? String,
        let english = dict["en"] as? String
            else {
                assertionFailure("Couldn't find all required properties.")
                return nil
        }
        self.korean = korean
        self.english = english
        allKoreanTerms.append(korean)
    }
}
