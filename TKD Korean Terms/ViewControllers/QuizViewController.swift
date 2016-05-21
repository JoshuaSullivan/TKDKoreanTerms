//
//  QuizViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 5/21/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var beltLevel: BeltLevel!
    
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var termLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = beltLevel.name
        
        guard let categories = beltLevel.categories else {
            languageLabel.hidden = true
            termLabel.text = NSLocalizedString("This belt level has no terms.", comment: "Warning when a belt level has no terms.")
            return
        }
        
        let terms = categories.flatMap {
            category in
            return category.terms
        }
        
        print(terms)
    }
}
