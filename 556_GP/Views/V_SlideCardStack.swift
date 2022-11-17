//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz questions withing a category
//

import SwiftUI

struct V_SlideCardStack: View {
    
    @EnvironmentObject var quizData: QuizViewModel
    
    @State private var iterator: Int = 0
    @State private var questionIndex: Int = 0
    @State var progressWidth = 0.0
    @State var quiz: [Quiz]
    @State var title: String
    @State var pressedButton: Int = 0
    
    @State var animateButton: Bool = false
    @State var buttonBgColor: Color = .white
    @State var buttonIsDisabled: Bool = true
    @State var buttonString: String = "Check"
    
    var body: some View {
        GeometryReader {geometry in
            VStack(spacing: 0){
                NavigationStack {
                    VStack(spacing: 0){
                        
                        // Drawing progress bar
                        // TODO: Number of questions to the left from a bar
                        Path{ path in
                            path.move(to: CGPoint(x: 0, y: 10))
                            path.addLine(to: CGPoint(x: progressWidth, y: 10))
                        }
                        .stroke(Color.blue, lineWidth: 20).background(.gray)
                        .frame(height: 20)
                        .cornerRadius(12)
                        .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
                        
                        // Displaying questions
                        TabView(selection: $iterator) {
                            ForEach(quiz) { question in
                                //                                V_SlideCard(question: question, pressedButton: self.$pressedButton)
                                VStack{
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(question.question)
                                            .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center){
                                            
                                            ForEach(question.answers) { answer in
                                                Button(action: {
                                                    pressedButton = answer.id
                                                    buttonIsDisabled = false
                                                })
                                                {
                                                    Text(answer.answer)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                                        .frame(maxWidth:.infinity, alignment: .leading)
                                                        .background(answer.id == pressedButton ? buttonBgColor : .white)
                                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                                        .animation(.easeInOut, value: pressedButton)
                                                        .shadow(color: chooseAnswer(answer.id, pressedButton), radius: 2)
                                                }
                                            }
                                            
                                        }
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                                        
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 1)
                                    .padding(.init(top: 5, leading: 4, bottom: 10, trailing: 4))
                                    
                                }
                            }
                        }
                        .animation(.easeInOut, value: iterator)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onAppear{
                            // Assigning initial value to iterator
                            iterator = quiz[questionIndex].id
                            progressWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                        }
                        
                    }
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                }
                .navigationTitle("\(title)")
                .navigationBarTitleDisplayMode(.inline)
                
                HStack {
                    Button {
                        if buttonString == "Next Question" {
                            pressedButton = 0
                            buttonBgColor = .white
                            // Iterating through questions
                            questionIndex < (quiz.count - 1) ? (questionIndex += 1) : (questionIndex = quiz.count - 1)
                            // Assigning questions' ids so TabView selector can safely iterate through them
                            iterator = quiz[questionIndex].id
                            // Filling the progress bar
                            progressWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                            buttonString = "Check"
                        } else {
                            buttonBgColor = setColor(quiz[questionIndex].correctAnswer, pressedButton)
                            buttonString = "Next Question"}
                            withAnimation(.spring()) {
                                animateButton.toggle()
                            }
                            
                    } label: {
                        Spacer()
                        Text(buttonString)
                        Spacer()
                    }
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .frame(width: animateButton ? .infinity : .infinity, alignment: .center)
                    .disabled(buttonIsDisabled)
                    
                    Button {
                        // Iterating through questions
                        questionIndex < (quiz.count - 1) ? (questionIndex += 1) : (questionIndex = quiz.count - 1)
                        // Assigning questions' ids so TabView selector can safely iterate through them
                        iterator = quiz[questionIndex].id
                        // Filling the progress bar
                        progressWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                        // Reset color for the next question
                        pressedButton = 0
                    } label: {
                        Text("Skip >>")
                    }
//                    .frame(width: -1, height: -1)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
//                    .offset(x: animateButton ? 30 : 0, y: 0)
                }.padding()
            }
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(quiz: QuizViewModel().quizzesData, title: "2: Variables")
            .environmentObject(QuizViewModel())
    }
}
