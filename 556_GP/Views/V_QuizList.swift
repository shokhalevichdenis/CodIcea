//
//  ContentView.swift
//  556_GP
//
//  View of all the categories
//

import SwiftUI

var set: Set<String> = []
func uniCat() -> Array<String> {

    for each in quizzes {
        set.insert(each.category)
    }
    
    return Array(set).sorted()
}

struct V_QuizList: View {

    var body: some View {
        NavigationView {
            
            List(uniCat(), id: \.self){cat in
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
