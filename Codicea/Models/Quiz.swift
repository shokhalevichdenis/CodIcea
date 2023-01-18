//  Schema for a quiz question.

import Foundation
import SwiftUI

struct Answer: Hashable, Codable, Identifiable {
    var id: Int
    var answer: String
}

struct Quiz: Hashable, Codable, Identifiable {
    var id: Int
    var language: String
    var category: String
    var question: String
    var questionCode: String
    var correctAnswer: Int
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    var answers: [Answer]
}
