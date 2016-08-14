//
//  ViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 12/6/15.
//  Copyright © 2015 Joshua Sullivan. All rights reserved.
//

import UIKit

class BeltListViewController: UITableViewController {
    
    private struct SegueIdentifiers {
        static let quiz = "ListToQuizSegueIdentifier"
    }
    
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
        
        let emptyView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView = emptyView
        self.tableView.separatorInset = UIEdgeInsetsZero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let id = segue.identifier else { return }
        
        switch id {
        case SegueIdentifiers.quiz:
            guard let
                quizVC = segue.destinationViewController as? QuizViewController,
                level = selectedBeltLevel
                else {
                    assertionFailure("Either the following view controller is the wrong type or the selectedBeltLevel is unset.")
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
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }
    
    // UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBeltLevel = levels[indexPath.row]
        self.performSegueWithIdentifier(SegueIdentifiers.quiz, sender: nil)
    }
    
}

