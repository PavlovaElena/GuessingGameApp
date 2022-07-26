//
//  UserGuessingGameViewController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 25.06.2022.
//

import UIKit

class ComputerGuessingGameViewController: UIViewController {
    
    @IBOutlet weak var computerQuestionLabel: UILabel!
    @IBOutlet weak var tryNumberLabel: UILabel!
    
    @IBOutlet var userAnswerButtons: [UIButton]!
    
    var gameOptions: GameOptions!
    
    private var computerTriesCounter = 1
    private var minPoint = minValue
    private var maxPoint = maxValue
    private var median: Int {
        minPoint + (maxPoint - minPoint) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryNumberLabel.text = "Try № \(computerTriesCounter)"
        
        for button in userAnswerButtons {
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setComputerGuess()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userGuessingGameVC = segue.destination as? UserGuessingGameViewController else { return }
        userGuessingGameVC.gameOptions = gameOptions
        userGuessingGameVC.computerTriesCounter = computerTriesCounter
    }
    
    @IBAction func userAnswerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0 where gameOptions.userNumber < median:
            maxPoint = median - 1
        case 1 where gameOptions.userNumber == median:
            performSegue(withIdentifier: "showUserGuessing", sender: nil)
            return
        case 2 where gameOptions.userNumber > median:
            minPoint = median + 1
        default:
            showAlert(withMessage: "Check if the answer is correct")
            return
        }
        
        computerTriesCounter += 1
        tryNumberLabel.text = "Try № \(computerTriesCounter)"
        
        setComputerGuess()
    }
    
    @IBAction func remindButtonPressed() {
        let alert = UIAlertController.createAlertController(
            title: "Oops",
            message: "You guessed the number \(gameOptions.userNumber)"
        )
        present(alert, animated: true)
    }
    
    private func showAlert(withMessage message: String) {
        let alert = UIAlertController.createAlertController(
            title: "Incorrect answer",
            message: message
        )
        present(alert, animated: true)
    }
    
    private func setComputerGuess() {
        computerQuestionLabel.text = ""
        computerQuestionLabel.animation(typing: "Your number is - \(median)?")
    }
}
