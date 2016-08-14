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
    
    private let defaultColor: UIColor = UIColor.darkGrayColor()
    private let correctColor: UIColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
    private let incorrectColor: UIColor = UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)
    
    // MARK: - Properties
    
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
        resetButtonAppearance()
        
        let term = terms[index]
        termLabel.text = term.english
        correctAnswer = term.korean
        
        let answers = generateAnswers(correctAnswer)
        for (i, answer) in answers.enumerate() {
            buttons[i].setTitle(answer, forState: .Normal)
        }
        
        index += 1
        if index == terms.count {
            terms = terms.shuffled()
            index = 0
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
    
    private func resetButtonAppearance() {
        buttons.forEach {
            button in
            button.alpha = 1.0
            button.enabled = true
            button.userInteractionEnabled = true
            button.backgroundColor = defaultColor
        }
    }
    
    @objc private func nextQuestionTimerDidFire(timer: NSTimer) {
        showNextTerm()
    }
    
    @IBAction private func answerButtonTapped(button: UIButton) {
        
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
                btn.userInteractionEnabled = false
            } else {
                btn.alpha = 0.5
                btn.enabled = false
            }
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1.5,
                                               target: self,
                                               selector: #selector(nextQuestionTimerDidFire(_:)),
                                               userInfo: nil,
                                               repeats: false)
    }
}
