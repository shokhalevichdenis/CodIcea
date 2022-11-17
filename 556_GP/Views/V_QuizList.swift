//
//  ContentView.swift
//  556_GP
//
//  Categories View
//

import SwiftUI
// Filtering questions by the passed category


// Displays categories of the quizzes in a list
struct V_QuizList: View {
    
    var body: some View {
        NavigationStack {
            List(uniqueCategory(), id: \.self){category in
                NavigationLink {
                    V_SlideCardStack(quiz: quizByValue(category), title: category)
                } label: {
                    V_QuizItem(category: category)
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct V_QuizList_Previews: PreviewProvider {
    static var previews: some View {
        V_QuizList()
            .environmentObject(QuizViewModel())
    }
}
