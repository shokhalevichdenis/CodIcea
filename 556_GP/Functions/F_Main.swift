//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//

import Foundation
import SwiftUI

// Changes color of the answer
func setColor(_ answerCorrect: Int, _ pressedButton: Int) -> Color {
    
    var buttonColor: Color = .white
        if answerCorrect == pressedButton {
            buttonColor = .green
        } else {
            buttonColor = .red
        }
    return buttonColor
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
