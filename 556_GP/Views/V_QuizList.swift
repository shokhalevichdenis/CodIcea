//
//  ContentView.swift
//  556_GP
//
//  View of all the categories
//

import SwiftUI

var set: Set<String> = []

// Filters unique categories and puts them into an array.
func uniqueCategory() -> Array<String> {

    for each in quizzes {
        set.insert(each.category)
    }
    
    return Array(set).sorted()
}

// Displays categories of the quizzes
struct V_QuizList: View {

    var body: some View {
        NavigationView {
            
            List(uniqueCategory(), id: \.self){cat in
                NavigationLink {
                    V_SlideCardStack(category: cat)
                } label: {
                    V_QuizItem(category: cat)
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
