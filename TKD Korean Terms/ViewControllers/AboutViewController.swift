//
//  AboutViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 6/18/17.
//  Copyright © 2017 Joshua Sullivan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction fileprivate func callTapped(sender: AnyObject?) {
        let telString = "tel:1-952-975-6000"
        guard
            let url = URL(string: telString),
            UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
    @IBAction fileprivate func mapTapped(sender: AnyObject?) {
        let mapString = "http://maps.apple.com/?q=7916+Mitchell+Road,+Eden+Prairie,+MN+55344"
        guard
            let url = URL(string: mapString),
            UIApplication.shared.canOpenURL(url)
            else {
                return
        }
        UIApplication.shared.openURL(url)
    }
    
    @IBAction fileprivate func websiteTapped(sender: AnyObject?) {
        let webString = "http://www.mastermoontkd.com"
        guard
            let url = URL(string: webString),
            UIApplication.shared.canOpenURL(url)
            else {
                return
        }
        UIApplication.shared.openURL(url)
    }
    
    @IBAction fileprivate func questionTapped(sender: AnyObject?) {
        let emailString = "mailto:joshuasullivan+mmtkd@gmail.com"
        guard
            let url = URL(string: emailString),
            UIApplication.shared.canOpenURL(url)
            else {
                return
        }
        UIApplication.shared.openURL(url)
    }

}
