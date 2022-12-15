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
    @Binding var lWrongAnswersForPlot: [[Int]]
    
    var body: some View {
        NavigationStack {
            Text("\(chosenLanguage)")
                .font(Font.custom("Futura Medium", size: 23))
                .multilineTextAlignment(.leading)
            
            List {
                ForEach(searchResults, id: \.self) { category in
                    NavigationLink {
                        V_SlideCardStack(lWrongAnswersForPlot: $lWrongAnswersForPlot, quiz: quizByValue(category, quiz: quizData.quizzesData), title: category)
                    } label: {
                        V_QuizItem(category: category)
                    }
                }
            }
            .searchable(text: $searchText)
            .listStyle(.plain)
            .padding(.trailing, 20)
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 25))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 20)
                    }
                }
            }
            .searchable(text: $searchText)
        }
        .accentColor(.black)
    }
    // Search results
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
        V_QuizList(lWrongAnswersForPlot: Binding.constant([[0,0]]))
            .environmentObject(QuizViewModel())
    }
}
