//
//  TermsDataService.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 3/26/17.
//  Copyright © 2017 Joshua Sullivan. All rights reserved.
//

import Foundation

class TermsDataService {
    
    // MARK: - Singleton
    
    class var shared: TermsDataService {
        return _shared
    }
    
    fileprivate static let _shared = TermsDataService()
    
    // MARK: - Properties
    
    fileprivate(set) var levels: [BeltLevel] = []
    
    // MARK: - Lifecycle
    
    init() {
        let dataURL = Bundle.main.url(forResource: "KoreanTerms", withExtension: "plist")!
        guard let data = NSDictionary(contentsOf: dataURL) else {
            assertionFailure("COULDN'T LOAD DATA!!!!")
            return
        }
        guard let levels = data["beltLevels"] as? [DataDictionary] else {
            assertionFailure("Couldn't find beltLevels in the data dictionary.")
            return
        }
        
        self.levels = levels.flatMap({ BeltLevel(dict: $0) }).sorted(by: {$0.level < $1.level})
        
    }
}
