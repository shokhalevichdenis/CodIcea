//  Contains reusable functions.

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
            player.prepareToPlay()
            player.delegate = self
        } catch {
            print("ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}
