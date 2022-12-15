//
//  ContentView.swift
//  556_GP
//
//  Categories View
//

import SwiftUI

// Displays categories of the quizzes in a list
struct V_QuizList: View {
    
    @EnvironmentObject var quizData: QuizViewModel
    @State var chosenLanguage: String = ""
    @State var searchText: String = ""
    
    
    var body: some View {
        NavigationStack {
            Text("\(chosenLanguage)")
                .font(Font.custom("Futura Medium", size: 23))
                .multilineTextAlignment(.leading)
            
            List(uniqueCategory(), id: \.self){category in
                NavigationLink {
                    V_SlideCardStack(quiz: quizByValue(category, quiz: quizData.quizzesData), title: category)
                } label: {
                    V_QuizItem(category: category)
                }
            }
            .listStyle(.plain)
            .padding(.trailing, 20)
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 25))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 20)
                    }
                }
            }
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text("\(result)").searchCompletion(result)
                }
            }
        }
        .accentColor(.black)
    }
    var searchResults: [String] {
        if searchText.isEmpty {
            return uniqueCategory()
        } else {
            return uniqueCategory().filter { $0.contains(searchText) }
        }
    }
}

struct V_QuizList_Previews: PreviewProvider {
    static var previews: some View {
        V_QuizList()
            .environmentObject(QuizViewModel())
    }
}
