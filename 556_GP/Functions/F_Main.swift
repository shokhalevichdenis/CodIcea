//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//

import Foundation
import SwiftUI
import AVFAudio

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
func quizByValue(_ filterValue: String, quiz: [Quiz]) -> [Quiz] {
    return quiz.filter { question in
        (filterValue == question.category)
    }
}


// Class for a player to handle track events
class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    var player = AVAudioPlayer()
    func playSong(songFileName: String) {
        guard let soundFile = NSDataAsset(name: songFileName) else {
            print("Could not read file named \(songFileName)")
            return
        }
        do {
            player = try AVAudioPlayer(data: soundFile.data)
            player.play()
            player.delegate = self
        } catch {
            print("ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

// Highlights code in queestion
func hilightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
        var result: Text!
        let parts = str.components(separatedBy: searched)
        for i in parts.indices {
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            if i != parts.count - 1 {
                result = result + Text(searched).bold().foregroundColor(Color("var"))
            }
        }
        return result ?? Text(str)
    }
