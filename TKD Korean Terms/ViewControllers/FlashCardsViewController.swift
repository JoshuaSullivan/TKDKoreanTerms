//
//  FlashCardsViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 3/26/17.
//  Copyright © 2017 Joshua Sullivan. All rights reserved.
//

import UIKit

class FlashCardsViewController: UIViewController {
    
    var beltLevel: BeltLevel!
    
    var terms: [Term] = []
    
    var index: Int = 0
    
    var currentTerm: Term?
    
    var isShowingQuestion = true
    
    var cardTap: UITapGestureRecognizer!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var card: UIView! {
        didSet {
            card.layer.cornerRadius = 16.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = beltLevel.name
        
        guard let categories = beltLevel.categories else {
            assertionFailure("No categories in this belt level!")
            return
        }
        terms = categories.flatMap({ return $0.terms }).shuffled()
        guard !terms.isEmpty else {
            assertionFailure("No terms to be found!")
            return
        }
        cardTap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(sender:)))
        card.addGestureRecognizer(cardTap)
        showNext(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func showNext(animated: Bool = true) {
        isShowingQuestion = true
        
        let term = terms[index]
        self.currentTerm = term
        
        guard animated else {
            self.label.text = term.english
            self.index = (self.index + 1) % self.terms.count
            if self.index == 0 {
                self.terms = self.terms.shuffled()
            }
            return
        }
        
        let w = self.view.bounds.width
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = self.card.transform.translatedBy(x: -w, y: 0.0)
        }) { (completed) in
            self.label.text = term.english
            self.card.transform = self.card.transform.translatedBy(x: w * 2.0, y: 0.0)
            UIView.animate(withDuration: 0.2, animations: {
                self.card.transform = self.card.transform.translatedBy(x: -w, y: 0.0)
            }, completion: {
                (completed) in
                self.index = (self.index + 1) % self.terms.count
                if self.index == 0 {
                    self.terms = self.terms.shuffled()
                }
            })
        }
    }
    
    fileprivate func flipToAnswer() {
        guard let term = currentTerm else {
            assertionFailure("Where's the current term?")
            return
        }
        self.isShowingQuestion = false
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            self.card.transform = CGAffineTransform(scaleX: 0.01, y: 1.0)
        }, completion: { (completed) in
            self.label.text = term.korean
            UIView.animate(withDuration: 0.15, animations: {
                self.card.transform = .identity
            })
        })
    }
    
    @objc fileprivate func cardTapped(sender: UITapGestureRecognizer) {
        if isShowingQuestion {
            flipToAnswer()
        } else {
            showNext()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
