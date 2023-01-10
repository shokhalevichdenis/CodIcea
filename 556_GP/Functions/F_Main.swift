//
//  C_Main.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/25/22.
//  Contains reusable functions.
//

import Foundation
import SwiftUI
import AVFAudio

// Changes color of the answer.
func checkAnswer(_ answerCorrect: Int, _ pressedButton: Int) -> String {
    return answerCorrect == pressedButton ? "correct" : "wrong"
}

// Changes color of a selected answer.
func chooseAnswer(_ answerId: Int, _ pressedButton: Int) -> Color {    
    return answerId == pressedButton ? .gray : .white
}

// Filters unique categories and puts them into an array.
func uniqueCategory() -> Array<String> {
    let set: Set<String> = Set(QuizViewModel().quizzesData.map({ $0.category }))
    return Array(set).sorted()
}

// Returns filtered quizzes
func quizByValue(_ filterValue: String, quiz: [Quiz]) -> [Quiz] {
    return quiz.filter { $0.category == filterValue }
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

// Highlights code syntax in a queestion (draft).
// TODO: Move to a separate module.
func highlightedText(str: String, searched: [(word: String, color: Color)]) -> Text {
    guard !str.isEmpty && !searched.isEmpty else {return Text(str)}
    let parts = str.components(separatedBy: [" "])
    var result: Text!
    for part in parts {
        var found = false
        for each in searched {
            if (each.word == part) {
                if result == nil {
                    result = Text(part + " ").bold().foregroundColor(each.color)
                } else {
                    result = result + Text(part + " ").bold().foregroundColor(each.color)
                }
                found = true
                break
            }
        }
        if !found {
            if result == nil {
                result = Text(part + " ")
            } else {
                result = result + Text(part + " ")
            }
        }
    }
    return result ?? Text(str)
}
