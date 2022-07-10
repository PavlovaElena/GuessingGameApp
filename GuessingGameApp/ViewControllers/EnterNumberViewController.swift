//
//  EnterNumberViewController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 25.06.2022.
//

import UIKit

class EnterNumberViewController: UIViewController {
    
    @IBOutlet weak var userNumberTF: UITextField!
    @IBOutlet weak var enterTheNumberButton: UIButton!
    
    private var gameOption = GameOptions.getGameOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterTheNumberButton?.isUserInteractionEnabled = false
        userNumberTF?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let computerGuessingGameVC = segue.destination as? ComputerGuessingGameViewController else { return }
        computerGuessingGameVC.gameOption = gameOption
    }
    
    @IBAction func enterTheNumberPressed() {
        guard let userNumberString = userNumberTF.text else { return }
        
        guard let userNumber = Int(userNumberString) else {
            showAlert(withMessage: "Please enter a number")
            return
        }
        
        userNumber >= 1 && userNumber <= 100
        ? gameOption.userNumber = userNumber
        : showAlert(withMessage: "Please enter a number from 0 to 100")
    }
    
    @objc private func editingChanged() {
        if userNumberTF.text != "" {
            enterTheNumberButton.isUserInteractionEnabled = true
            enterTheNumberButton.alpha = 1
        } else {
            enterTheNumberButton.isUserInteractionEnabled = false
            enterTheNumberButton.alpha = 0.5
        }
    }
    
    private func showAlert(withMessage message: String) {
        let alert = UIAlertController.createAlertController(
            title: "Wrong format!",
            message: message,
            cleanTextField: userNumberTF
        )
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension EnterNumberViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.createKeyboardToolbar(for: textField)
    }
}

