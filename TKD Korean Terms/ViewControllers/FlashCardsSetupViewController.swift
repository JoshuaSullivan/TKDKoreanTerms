//
//  FlashCardsSetupViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 3/26/17.
//  Copyright © 2017 Joshua Sullivan. All rights reserved.
//

import UIKit

class FlashCardsSetupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var levels: [BeltLevel] = []
    
    fileprivate var selectedBeltLevel: BeltLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levels = TermsDataService.shared.levels
        let emptyView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView = emptyView
        self.tableView.separatorInset = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFlashCardsSegue" {
            guard
                let dest = segue.destination as? FlashCardsViewController,
                let beltLevel = self.selectedBeltLevel
            else {
                assertionFailure("Unexpected configuration.")
                return
            }
            dest.beltLevel = beltLevel
        }
    }
    
}

extension FlashCardsSetupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let level = levels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = level.beltName
        cell.imageView?.image = UIImage(named: level.icon)
        return cell
    }
}

extension FlashCardsSetupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBeltLevel = levels[indexPath.row]
        self.performSegue(withIdentifier: "showFlashCardsSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
