//
//  QuizViewController.swift
//  TKD Korean Terms
//
//  Created by Joshua Sullivan on 5/21/16.
//  Copyright © 2016 Joshua Sullivan. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // MARK: Constants
    
    fileprivate let defaultColor: UIColor = UIColor.darkGray
    fileprivate let correctColor: UIColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
    fileprivate let incorrectColor: UIColor = UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)
    
    // MARK: - Properties
    
    var beltLevel: BeltLevel!
    
    @IBOutlet fileprivate weak var languageLabel: UILabel!
    @IBOutlet fileprivate weak var termLabel: UILabel!
    
    @IBOutlet fileprivate var buttons: [UIButton] = []
    
    fileprivate var terms: [Term] = []
    fileprivate var index: Int = 0
    
    fileprivate var correctAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = beltLevel.name
        
        guard let categories = beltLevel.categories else {
            languageLabel.isHidden = true
            termLabel.text = NSLocalizedString("This belt level has no terms.", comment: "Warning when a belt level has no terms.")
            return
        }
        
        terms = categories.flatMap({
            category in
            return category.terms
        }).shuffled()
        
        showNextTerm()
    }
    
    fileprivate func showNextTerm() {
        resetButtonAppearance()
        
        let term = terms[index]
        termLabel.text = term.english
        correctAnswer = term.korean
        
        let answers = generateAnswers(correctAnswer)
        for (i, answer) in answers.enumerated() {
            buttons[i].setTitle(answer, for: UIControlState())
        }
        
        index += 1
        if index == terms.count {
            terms = terms.shuffled()
            index = 0
        }
    }
    
    fileprivate func generateAnswers(_ correctAnswer: String) -> [String] {
        var answers: [String] = [correctAnswer]
        repeat {
            let term = allKoreanTerms.randomElement()
            if !answers.contains(term) {
                answers.append(term)
            }
        } while (answers.count < buttons.count)
        return answers.shuffled()
    }
    
    fileprivate func resetButtonAppearance() {
        buttons.forEach {
            button in
            button.alpha = 1.0
            button.isEnabled = true
            button.isUserInteractionEnabled = true
            button.backgroundColor = defaultColor
        }
    }
    
    @objc fileprivate func nextQuestionTimerDidFire(_ timer: Timer) {
        showNextTerm()
    }
    
    @IBAction fileprivate func answerButtonTapped(_ button: UIButton) {
        
        self.buttons.forEach { btn in
            guard let term = btn.titleLabel?.text else {
                preconditionFailure("Unable to get button title.")
            }
            let isCorrect = term == correctAnswer
            if btn == button {
                btn.backgroundColor = isCorrect ? correctColor : incorrectColor
            }
            if isCorrect {
                btn.backgroundColor = correctColor
                btn.isUserInteractionEnabled = false
            } else {
                btn.alpha = 0.5
                btn.isEnabled = false
            }
        }
        
        Timer.scheduledTimer(timeInterval: 1.5,
                                               target: self,
                                               selector: #selector(nextQuestionTimerDidFire(_:)),
                                               userInfo: nil,
                                               repeats: false)
    }
}
