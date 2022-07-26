//
//  ComputerGuessingGameViewController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 25.06.2022.
//

import UIKit

class UserGuessingGameViewController: UIViewController {
    
    @IBOutlet weak var tryNumberLabel: UILabel!
    @IBOutlet weak var userGuessTextField: UITextField!
    @IBOutlet weak var computerResponseLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    
    var gameOptions: GameOptions!
    var computerTriesCounter: Int!
    
    private var userTriesCounter = 1
    private var minPoint = minValue
    private var maxPoint = maxValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryNumberLabel.text = "Try № \(userTriesCounter)"
        computerResponseLabel.text = ""
        guessButton?.isUserInteractionEnabled = false
        userGuessTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        computerResponseLabel.animation(typing: "Enter a number from \(minValue) to \(maxValue)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.computerTriesCounter = computerTriesCounter
        resultVC.userTriesCounter = userTriesCounter
    }
    
    @IBAction func userGuessButtonPressed() {
        userTriesCounter += 1
        tryNumberLabel.text = "Try № \(userTriesCounter)"
        view.endEditing(true)
        
        guard let userGuessString = userGuessTextField.text else { return }
        
        guard let userGuess = Int(userGuessString) else {
            showAlert(withMessage: "Please enter a number")
            return
        }
        
        userGuess >= minValue && userGuess <= maxValue
        ? getComputerResponse(about: userGuess)
        : showAlert(withMessage: "Please enter a number from \(minValue) to \(maxValue)")
        
        userGuessTextField.text = ""
        
    }
    
    @objc private func editingChanged() {
        if userGuessTextField.text != "" {
            guessButton.isUserInteractionEnabled = true
            guessButton.alpha = 1
        } else {
            guessButton.isUserInteractionEnabled = false
            guessButton.alpha = 0.5
        }
    }
    
    private func getComputerResponse(about number: Int) {
        computerResponseLabel.text = ""
        switch number {
        case 1..<gameOptions.computerNumber:
            if number > minPoint {
                minPoint = number
            }
            computerResponseLabel.animation(typing: "You didn't guess. My number is greater then \(minPoint)")
        case gameOptions.computerNumber:
            performSegue(withIdentifier: "showResult", sender: nil)
        default:
            if number < maxPoint {
                maxPoint = number
            }
            computerResponseLabel.animation(typing: "You didn't guess. My number is less then \(maxPoint)")
        }
    }
    
    private func showAlert(withMessage message: String) {
        let alert = UIAlertController.createAlertController(
            title: "Wrong format",
            message: message,
            cleanTextField: userGuessTextField
        )
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension UserGuessingGameViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.createKeyboardToolbar(for: textField)
    }
}
