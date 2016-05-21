//
//  ViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 12/6/15.
//  Copyright © 2015 Joshua Sullivan. All rights reserved.
//

import UIKit

class BeltListViewController: UITableViewController {
    
    var levels: [BeltLevel]!
    
    var selectedBeltLevel: BeltLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataURL = NSBundle.mainBundle().URLForResource("KoreanTerms", withExtension: "plist")!
        guard let data = NSDictionary(contentsOfURL: dataURL) else {
            assertionFailure("COULDN'T LOAD DATA!!!!")
            return
        }
        guard let levels = data["beltLevels"] as? [DataDictionary] else {
            assertionFailure("Couldn't find beltLevels in the data dictionary.")
            return
        }
        
        self.levels = levels.flatMap({ BeltLevel(dict: $0) }).sort({$0.level < $1.level})
        print(levels)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print(segue.identifier)
        guard let id = segue.identifier else { return }
        
        switch id {
        case "ListToQuizSegueIdentifier":
            guard let
                quizVC = segue.destinationViewController as? QuizViewController,
                level = selectedBeltLevel
                else {
                    return
            }
            quizVC.beltLevel = level
            
        default: break
        }
    }
    
    // UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let beltLevel = levels[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("BeltCellReuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = beltLevel.beltName
        cell.imageView?.image = UIImage(named: beltLevel.icon)
        return cell
    }
    
    // UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBeltLevel = levels[indexPath.row]
    }
    
}

