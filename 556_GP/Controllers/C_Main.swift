//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//

import Foundation
import SwiftUI

func setColor(_ answerCorrect: Int, _ answerId: Int, _ pressedButton: Int) -> Color {
    
    var buttonColor: Color = .white
    
    if (answerId == pressedButton) {
        if answerCorrect == answerId {
            buttonColor = .green
        }
        if answerCorrect != answerId {
            buttonColor = .red
        }
    } else {
        buttonColor = .white
    }
    return buttonColor
}



