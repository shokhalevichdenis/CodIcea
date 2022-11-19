//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//

import Foundation
import SwiftUI

// Changes color of the answer
func checkAnswer(_ answerCorrect: Int, _ pressedButton: Int) -> String {
    
    var ifCoorect: String = ""
        if answerCorrect == pressedButton {
            ifCoorect = "correct"
        } else {
            ifCoorect = "wrong"
        }
    return ifCoorect
}

// Changes color of a selected answer
func chooseAnswer(_ answerId: Int, _ pressedButton: Int) -> Color {
    
    var buttonColor: Color = .white
    
    if (answerId == pressedButton) {
        buttonColor = .gray
    } else {
        buttonColor = .white
    }
    return buttonColor
}

// Filters unique categories and puts them into an array.
func uniqueCategory() -> Array<String> {
    var set: Set<String> = []
    for question in QuizViewModel().quizzesData {
        set.insert(question.category)
    }
    return Array(set).sorted()
}

// Returns filtered quizzes
func quizByValue(_ filterValue: String) -> [Quiz] {
    QuizViewModel().quizzesData.filter { question in
        (filterValue == question.category)
    }
}
