//
//  ResultViewController.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 25.06.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var userScoresLabel: UILabel!
    @IBOutlet weak var computerScoresLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var computerTriesCounter: Int!
    var userTriesCounter: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
    }
    
    private func showResult() {
        userScoresLabel.text = "Your's tries count: \(userTriesCounter ?? 0)"
        computerScoresLabel.text = "Computer's tries count: \(computerTriesCounter ?? 0)"
        resultDetermination()
    }
    
    private func resultDetermination() {
        if userTriesCounter < computerTriesCounter {
            resultLabel.text = #"Congratulations!\#nYou have won 🥳"#
        } else if userTriesCounter > computerTriesCounter {
            resultLabel.text = #"The computer won 🤖\#nDon't be upset!"#
        } else {
            resultLabel.text = "Even score ✌️"
        }
    }
}
