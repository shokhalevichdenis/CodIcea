//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz cards withing a category
//

import SwiftUI

struct V_SlideCardStack: View {
    @State private var quizIndex = 0
    @State private var width = 0
    @State var category: String
    @State var pressedButton: Int = 0
    
    // Filtering quizzes to display only those with the passed category
    var quizByCategory: [Quiz] {
        quizzes.filter { quiz in
            (category == quiz.category)
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            NavigationView {
                VStack(spacing: 0){
                    V_SlideCard(quiz: quizByCategory[quizIndex], check: 1)
                    
                    Path{ path in
                        path.move(to: CGPoint(x: 0, y: 10))
                        path.addLine(to: CGPoint(x: width, y: 10))
                    }
                    .stroke(Color.green, lineWidth: 20).background(.gray)
                    .frame(height: 20)
                }
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding()
            }.navigationTitle("\(category)")

            Button("Next Quiz") {
                // Next question
                quizIndex < quizByCategory.count-1 ? (quizIndex += 1) : (quizIndex = 0)
                // Fill progress bar
                width += (360 / quizByCategory.count)
                // Reset color
                pressedButton = 0
            }
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(category: "2: Variables")
    }
}
