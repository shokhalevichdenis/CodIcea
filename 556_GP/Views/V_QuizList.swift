//
//  ContentView.swift
//  556_GP
//
//  Categories View
//

import SwiftUI

// Set for storing unique categories
var set: Set<String> = []

// Filters unique categories and puts them into an array.
func uniqueCategory() -> Array<String> {
    for question in quizzes {
        set.insert(question.category)
    }
    return Array(set).sorted()
}

// Displays categories of the quizzes in a list
struct V_QuizList: View {
    var body: some View {
        NavigationStack {
            List(uniqueCategory(), id: \.self){category in
                NavigationLink {
                    V_SlideCardStack(category: category)
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
    }
}
