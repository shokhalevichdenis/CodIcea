//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz cards withing a category
//

import SwiftUI

struct V_SlideCardStack: View {
    @State private var quizIndex = 0
    var category: String
    
    var quizByCategory: [Quiz] {
        quizzes.filter { quiz in
            (category == quiz.category)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                V_SlideCard(quiz: quizByCategory[quizIndex])
                
                Button("Next Quiz") {
                    quizIndex < quizByCategory.count-1 ? (quizIndex += 1) : (quizIndex = 0)
                }
            }
        } .navigationTitle("\(category)")
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(category: "1: variables")
    }
}
