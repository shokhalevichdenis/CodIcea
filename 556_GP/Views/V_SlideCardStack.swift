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
                TabView {
                    ForEach(quizByCategory) { quiz in
                        V_SlideCard(quiz: quiz)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
        }.navigationTitle("\(category)")
            .cornerRadius(12)
            .shadow(radius: 6)
            .padding()
        
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(category: "2: Variables")
    }
}

//                Button("Next Quiz") {
//                    quizIndex < quizByCategory.count-1 ? (quizIndex += 1) : (quizIndex = 0)
//                }
