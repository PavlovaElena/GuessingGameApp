//
//  GameOptions.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 26.06.2022.
//

let minValue = 1
let maxValue = 100

struct GameOptions {
    var userNumber: Int
    var computerNumber: Int
    
    static func getGameOptions() -> GameOptions {
        GameOptions(
            userNumber: 1,
            computerNumber: Int.random(in: minValue...maxValue)
        )
    }
}
