//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz questions withing a category
//

import SwiftUI

var myPlayer = AudioPlayer();
struct V_SlideCardStack: View {
    
    @EnvironmentObject var quizData: QuizViewModel
    
    @State private var iterator: Int = 0
    @State private var questionIndex: Int = 0
    @State var progressBarWidth = 0.0
    @State var quiz: [Quiz]
    @State var title: String
    @State var pressedButton: Int = 0
    
    @State var animateMainButton: Bool = false
    @State var buttonBgColor: Color = .white
    @State var buttonIsDisabled: Bool = true
    @State var buttonString: String = "Check"
    
    @State var checkButtonColor: Color = Color("LightGray")
    @State var checkButtonBorColor: Color = Color("LightGray2")
    @State var checkButtonFColor: Color = Color("LightGray3")
    
    @State var animationColor: String = "none"
    @State var popUpPaneWidth: Int = 0
    
    @State var buttonOffset = 0
    
    // TODO: ADD Private where necessary
    // TODO: Prevent Horizontal View
    // TODO: Last Page
    
    // Next question
    func nextQuestion() {
        questionIndex < (quiz.count - 1) ? (questionIndex += 1) : (questionIndex = quiz.count - 1)
        // Assigning questions' ids so TabView selector can safely iterate through them
        iterator = quiz[questionIndex].id
        pressedButton = 0
        buttonIsDisabled = true
    }
    
    var body: some View {
        GeometryReader {geometry in
            VStack(spacing: 0){
                NavigationStack {
                    VStack(spacing: 0){
                        
                        // Drawing progress bar
                        // TODO: Number of questions to the left from a bar
                        Path{ path in
                            path.move(to: CGPoint(x: 0, y: 10))
                            path.addLine(to: CGPoint(x: progressBarWidth, y: 10))
                        }
                        .stroke(Color.blue, lineWidth: 20).background(.gray)
                        .frame(height: 20)
                        .cornerRadius(12)
                        .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
                        
                        // Displaying questions
                        TabView(selection: $iterator) {
                            ForEach(quiz) { question in
                                VStack{
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(question.question)
                                            .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center){
                                            
                                            ForEach(question.answers) { answer in
                                                Button {
                                                    pressedButton = answer.id
                                                    buttonIsDisabled = false
                                                    checkButtonColor = .green
                                                    checkButtonFColor = .black
                                                    animationColor = "none"
                                                } label: {
                                                    if (answer.id == pressedButton) {
                                                        V_CardButtons(strokeColor: Color("LightGray3"), animationColor: $animationColor, text: answer.answer)
                                                    } else if (pressedButton != answer.id) {
                                                        V_CardButtons(animationColor: $animationColor, text: answer.answer)
                                                    }
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
                        .animation(.easeIn, value: iterator)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onAppear{
                            // Assigning initial value to iterator
                            iterator = quiz[questionIndex].id
                            progressBarWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                        }
                    }
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                
                HStack {
                    if !animateMainButton {
                        Button {
                            nextQuestion()
                            progressBarWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                        } label: {
                            Text("Skip >>")
                        }
                        .buttonStyle(MainButtonStyle(color: .blue, textColor: .black, borderColor: .blue))
                    } else {
                        EmptyView()
                    }
                    
                    ZStack {
                        Button {
                            if buttonString == "Next Question" {
                                buttonBgColor = .white
                                progressBarWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                                buttonString = "Check"
                                animateMainButton = false
                                buttonIsDisabled = true
                                
                                checkButtonColor = Color("LightGray")
                                checkButtonBorColor = Color("LightGray2")
                                checkButtonFColor = Color("LightGray3")
                                
                                popUpPaneWidth = 0
                                buttonOffset = 0
                                nextQuestion()
                            } else {
                                animateMainButton = true
                                buttonString = "Next Question"
                                popUpPaneWidth = 1
                                buttonOffset = 20
                            }
                            animationColor = checkAnswer(quiz[questionIndex].correctAnswer, pressedButton)
                            if (buttonString == "Next Question" && animationColor == "correct") {
                                myPlayer.playSong(songFileName: "corr")
                            } else if (buttonString == "Next Question" && animationColor == "wrong") {
                                myPlayer.playSong(songFileName: "wrng")
                            }
                        } label: {
                            HStack{
                                Spacer()
                                Text(buttonString)
                                Spacer()
                            }
                        }
                        .disabled(buttonIsDisabled)
                        .buttonStyle(MainButtonStyle(color: checkButtonColor, textColor: checkButtonFColor, borderColor: checkButtonBorColor))
                        .frame(width: geometry.size.width * 0.64)
                        .offset(y: CGFloat(buttonOffset))
                        
                        if buttonString == "Next Question" {
                            VStack(alignment: .leading){
                                if animationColor == "correct" {
                                    Group {
                                        Text("Correct!")
                                            .foregroundColor(.black)
                                            .padding(.leading, 35)
                                        V_CheckMarkIcon(animationDuration: 0.4, answerStrokeColor: .green)
                                            .padding(.top, -9)
                                    }
                                    .padding(-45) }
                                else {

                                    Group {
                                        Text("Wrong!")
                                            .foregroundColor(.black)
                                            .padding(.leading, 35)
                                        V_CheckMarkIcon(animationDuration: 0.4, answerStrokeColor: .red)
                                            .padding(.top, -9)
                                    }
                                    .padding(-45)
                                }
                            }
                            .frame(width: geometry.size.width * CGFloat(popUpPaneWidth), height: geometry.size.height * 0.17)
                            .background(Color("LightGray2"))
                            .zIndex(-1)
                        } else {
                            VStack{
                            }
                            .frame(height: geometry.size.height * 0.12)
                            .hidden()
                        }
                    }
                }
            }
            .navigationTitle("\(title)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(quiz: QuizViewModel().quizzesData, title: "2: Variables", animationColor: "none")
            .environmentObject(QuizViewModel())
    }
}
