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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = beltLevel.name
    }
}
