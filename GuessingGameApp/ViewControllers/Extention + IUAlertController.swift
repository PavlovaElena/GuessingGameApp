//
//  Extention + IUAlertController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 06.07.2022.
//

import UIKit

extension UIAlertController {
    static func createAlertController(title: String, message: String, cleanTextField: UITextField? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            cleanTextField?.text = ""
        }
        alert.addAction(okAction)
        return alert
    }
}
