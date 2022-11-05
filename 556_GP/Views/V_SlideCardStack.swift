//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz questions withing a category
//

import SwiftUI

struct V_SlideCardStack: View {
    @State private var iterator: Int = 0
    @State private var questionIndex: Int = 0
    @State var progressWidth = 0.0
    @State var category: String
    @State var pressedButton: Int = 0
    
    // Filtering questions by the passed category
    var quizByCategory: [Quiz] {
        quizzes.filter { question in
            (category == question.category)
        }
    }
    
    var body: some View {
        GeometryReader {geometry in
            VStack(spacing: 0){
                NavigationStack {
                    VStack(spacing: 0){
                        // Displaying questions
                        TabView(selection: $iterator) {
                            ForEach(quizByCategory) { question in
                                V_SlideCard(question: question, pressedButton: self.$pressedButton)
                            }
                        }
                        .animation(.easeInOut, value: iterator)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onAppear{
                            // Assigning initial value to iterator
                            iterator = quizByCategory[questionIndex].id
                            progressWidth += (Double(geometry.size.width-20) / (Double(quizByCategory.count)))
                        }                        
                        // Drawing progress bar
                        Path{ path in
                            path.move(to: CGPoint(x: 0, y: 10))
                            path.addLine(to: CGPoint(x: progressWidth, y: 10))
                        }
                        .stroke(Color.blue, lineWidth: 20).background(.gray)
                        .frame(height: 20)
                        .cornerRadius(12)
                    }
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                }
                .navigationTitle("\(category)")
                .navigationBarTitleDisplayMode(.inline)
                
                Button("Pass this question") {
                    // Iterating through questions
                    questionIndex < (quizByCategory.count - 1) ? (questionIndex += 1) : (questionIndex = quizByCategory.count - 1)
                    // Assigning questions' ids so TabView selector can safely iterate through them
                    iterator = quizByCategory[questionIndex].id
                    // Filling the progress bar
                    progressWidth += (Double(geometry.size.width-20) / (Double(quizByCategory.count)))
                    // Reset color for the next question
                    pressedButton = 0
                }
            }
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(category: "2: Variables")
    }
}
