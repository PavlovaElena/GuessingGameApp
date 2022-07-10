//
//  GameOptions.swift
//  GuessingGameApp
//
//  Created by Elena Pavlova on 26.06.2022.
//

struct GameOptions {
    var userNumber: Int
    var computerNumber: Int
    
//    var computerNumber: Int {
//        Int.random(in: 0...100)
//    }
    
    static func getGameOptions() -> GameOptions {
        GameOptions(
            userNumber: 1,
            computerNumber: Int.random(in: 1...100)
        )
    }
    
}
