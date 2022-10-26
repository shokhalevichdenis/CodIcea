//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//

import Foundation
import SwiftUI

func setColor(_ answerCorrect: Int, _ answerId: Int) -> Color {
    var buttonColor = Color.white
    
    if answerCorrect == 9 {
        buttonColor = Color.red
    } else {
        buttonColor = Color.white
    }
    
    return buttonColor
}


