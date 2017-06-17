//
//  ViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 12/6/15.
//  Copyright © 2015 Joshua Sullivan. All rights reserved.
//

import UIKit

class BeltListViewController: UITableViewController {
    
    fileprivate struct SegueIdentifiers {
        static let quiz = "ListToQuizSegueIdentifier"
    }
    
    var levels: [BeltLevel]!
    
    var selectedBeltLevel: BeltLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.levels = TermsDataService.shared.levels
        let emptyView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView = emptyView
        self.tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let id = segue.identifier else { return }
        
        switch id {
        case SegueIdentifiers.quiz:
            guard let
                quizVC = segue.destination as? QuizViewController,
                let level = selectedBeltLevel
                else {
                    assertionFailure("Either the following view controller is the wrong type or the selectedBeltLevel is unset.")
                    return
            }
            quizVC.beltLevel = level
            
        default: break
        }
    }
    
    // UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beltLevel = levels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeltCellReuseIdentifier", for: indexPath)
        cell.textLabel?.text = beltLevel.beltName
        cell.imageView?.image = UIImage(named: beltLevel.icon)
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    // UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBeltLevel = levels[indexPath.row]
        self.performSegue(withIdentifier: SegueIdentifiers.quiz, sender: nil)
    }
    
}

