//
//  UserGuessingGameViewController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 25.06.2022.
//

import UIKit

class ComputerGuessingGameViewController: UIViewController {
    
    @IBOutlet weak var computerQuestionLabel: UILabel!
    @IBOutlet weak var triesCountLabel: UILabel!
    
    var gameOption: GameOptions!
    
    private var countingComputerAttempts = 1
    private var minPoint = 1
    private var maxPoint = 100
    private var median: Int {
        minPoint + (maxPoint - minPoint) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userGuessingGameVC = segue.destination as? UserGuessingGameViewController else { return }
        userGuessingGameVC.gameOption = gameOption
    }
    
    @IBAction func userAnswerButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            gameOption.userNumber < median
            ? maxPoint = median - 1
            : showAlert(withMessage: "You guessed a number greater than this")
        case 1:
            gameOption.userNumber == median
            ? performSegue(withIdentifier: "showUserGuessing", sender: nil)
            : showAlert(withMessage: "You guessed another number")
        default:
            gameOption.userNumber > median
            ? minPoint = median + 1
            : showAlert(withMessage: "You guessed a number less than this")
        }
        
        countingComputerAttempts += 1
        setLabels()
    }
    
    @IBAction func showNumber() {
        let alert = UIAlertController.createAlertController(
            title: "Oops",
            message: "You guessed the number \(gameOption.userNumber)"
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
    
    private func setLabels() {
        triesCountLabel.text = "Try № \(countingComputerAttempts)"
        computerQuestionLabel.text = "Your number is - \(median)?"
    }
}
