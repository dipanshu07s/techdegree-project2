//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    let progress = Progress(totalUnitCount: 15)
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1335
    var inCorrectAnswerSound: SystemSoundID = 1329
    var timeUpSound: SystemSoundID = 1005
    
    var trivia = Trivia()
    var selectedQuestion: Question!
    
    var timer = Timer()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var optionButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playSound(gameSound)
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playSound(_ systemID: SystemSoundID) {
        AudioServicesPlaySystemSound(systemID)
    }
    
    func displayQuestion() {
        selectedQuestion = trivia.randomQuestion()
        questionField.text = selectedQuestion.question
        setButtonTitles(with: selectedQuestion.options, buttons: optionButtons)
        resultLabel.isHidden = true
        playAgainButton.isHidden = true
        startTimer()
    }
    
    func startTimer() {
        progressBar.progress = 0.0
        progress.completedUnitCount = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            guard self.progress.isFinished == false else {
                timer.invalidate()
                self.playSound(self.timeUpSound)
                self.displayAlert(withMessage: self.selectedQuestion.answer)
                return
            }
            
            self.progress.completedUnitCount += 1
            self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
    }
    
    func displayScore() {
        // Hide the answer uttons
        for button in optionButtons {
            button.isHidden = true
        }
        resultLabel.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func setButtonTitles(with option: [String], buttons: [UIButton]) {
        for (index, button) in buttons.enumerated() {
            if index < option.count {
                button.isHidden = false
                button.setTitle(option[index], for: .normal)
            } else {
                button.isHidden = true
            }
        }
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func displayResult(_ result: Bool, answer: String? = nil) {
        resultLabel.isHidden = false
        if result == true {
            resultLabel.textColor = .green
            resultLabel.text = "Correct!"
        } else {
            resultLabel.textColor = .red
            resultLabel.text = "Sorry, wrong answer!"
            if let answer = answer {
                displayAlert(withMessage: answer)
            }
        }
    }
    
    func displayAlert(withMessage message: String) {
        let controller = UIAlertController(title: "The correct answer is:", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in self.loadNextRound(delay: 0)} )
        controller.addAction(action)
        present(controller, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let correctAnswer = selectedQuestion.answer
        let buttonTitle = sender.title(for: .normal)
        if buttonTitle == correctAnswer {
            playSound(correctAnswerSound)
            correctQuestions += 1
            timer.invalidate()
            displayResult(true)
            loadNextRound(delay: 2)
        } else {
            playSound(inCorrectAnswerSound)
            timer.invalidate()
            displayResult(false, answer: correctAnswer)
        }
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        for button in optionButtons {
            button.isHidden = false
        }
        
        trivia.askedQuestions.removeAll()
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

}

