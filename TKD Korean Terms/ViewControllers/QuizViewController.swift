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
    
    @IBOutlet private var buttons: [UIButton] = []
    
    private var terms: [Term] = []
    private var index: Int = 0
    
    private var correctAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = beltLevel.name
        
        guard let categories = beltLevel.categories else {
            languageLabel.hidden = true
            termLabel.text = NSLocalizedString("This belt level has no terms.", comment: "Warning when a belt level has no terms.")
            return
        }
        
        terms = categories.flatMap({
            category in
            return category.terms
        }).shuffled()
        
        showNextTerm()
    }
    
    private func showNextTerm() {
        let term = terms[index]
        termLabel.text = term.english
        correctAnswer = term.korean
        
        let answers = generateAnswers(correctAnswer)
        for (i, answer) in answers.enumerate() {
            buttons[i].setTitle(answer, forState: .Normal)
        }
    }
    
    private func generateAnswers(correctAnswer: String) -> [String] {
        var answers: [String] = [correctAnswer]
        repeat {
            let term = allKoreanTerms.randomElement()
            if !answers.contains(term) {
                answers.append(term)
            }
        } while (answers.count < buttons.count)
        return answers.shuffled()
    }
    
    @IBAction private func answerButtonTapped(button: UIButton) {
        guard let term = button.titleLabel?.text else {
            preconditionFailure("Unable to get button title.")
        }
        if term == correctAnswer {
            debugPrint("Correct!")
        } else {
            debugPrint("Wrong!")
        }
    }
}
