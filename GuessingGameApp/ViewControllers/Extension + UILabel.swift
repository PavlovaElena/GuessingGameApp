//
//  Extension + UILabel.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 12.07.2022.
//

import UIKit

extension UILabel {
    func animation(typing answer: String){
        DispatchQueue.main.async {
            for char in answer {
                self.text?.append(char)
                RunLoop.current.run(until: Date() + 0.05)
            }
        }
    }
}
