//
//  V_Splash.swift
//  556_GP
//
//  View of the quiz questions withing a category
//

import SwiftUI
import Foundation

// Access Shared Defaults Object
let userDefaults = UserDefaults.standard
// Initialize Player
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
    
    @State var answerBorderColor: String = "none"
    @State var popUpPaneWidth: Int = 0
    @State var buttonOffset = 0
    
    // Read/Get Array of Ids
    @State var wrongAnswers: [Int] = userDefaults.object(forKey: "myKey") as? [Int] ?? []
    
    @State var showMenu = false
    
    // TODO: ADD Private where necessary
    // TODO: Prevent Horizontal View
    // TODO: Last Page
    
    // Next question
    func nextQuestion() {
        questionIndex < (quiz.count - 1) ? (questionIndex += 1) : (questionIndex = quiz.count)
        // Assigning questions' ids so TabView selector can safely iterate through them
        if !(questionIndex == quiz.count) {
            iterator = quiz[questionIndex].id
        }
        pressedButton = 0
        buttonIsDisabled = true
    }
    
    var body: some View {
        VStack {
            if !(questionIndex == quiz.count) {
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
                                .stroke(RadialGradient(gradient: Gradient(colors: [.green, .clear]), center: .center, startRadius: 2, endRadius: 620), lineWidth: 20).background(Color("LightGray"))
                                
                                .frame(height: 20)
                                .cornerRadius(12)
                                .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
                                
                                // Displaying questions and answers
                                TabView(selection: $iterator) {
                                    ForEach(quiz) { question in
                                        VStack{
                                            VStack(alignment: .leading, spacing: 0) {
                                                hilightedText(str: question.question, searched: "let")
                                                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                                                
                                                Spacer()
                                                
                                                VStack(alignment: .center){
                                                    
                                                    ForEach(question.answers) { answer in
                                                        Button {
                                                            pressedButton = answer.id
                                                            buttonIsDisabled = false
                                                            checkButtonColor = .green
                                                            checkButtonFColor = .black
                                                            answerBorderColor = "none"
                                                        } label: {
                                                            if (answer.id == pressedButton) {
                                                                V_CardButtons(strokeColor: Color("LightGray3"), answerBorderColor: $answerBorderColor, text: answer.answer)
                                                            } else if (pressedButton != answer.id) {
                                                                V_CardButtons(answerBorderColor: $answerBorderColor, text: answer.answer)
                                                            }
                                                        }
                                                    }
                                                }
                                                .disabled(buttonString == "Next Question" ? true : false)
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
                                .animation(.easeOut, value: iterator)
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .onAppear{
                                    // Assigning initial value to iterator
                                    iterator = quiz[questionIndex].id
                                    progressBarWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                                }
                                
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        }
                        
                        // Next and Check buttions
                        HStack {
                            if !animateMainButton {
                                Button {
                                    nextQuestion()
                                    progressBarWidth += (Double(geometry.size.width-20) / (Double(quiz.count)))
                                    print(questionIndex)
                                } label: {
                                    Text("Skip >>")
                                }
                                .buttonStyle(MainButtonStyle(color: .white, textColor: .black, borderColor: .black))
                                .frame(width: geometry.size.width * 0.3)
                                .offset(x: -8)
                            } else {
                                EmptyView()
                            }
                            
                            ZStack {
                                Button {
                                    if (buttonString == "Next Question") {
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
                                    } else if (buttonString == "View Results") {
                                        nextQuestion()
                                        print(questionIndex)
                                    } else {
                                        if (questionIndex < quiz.count - 1) {
                                            animateMainButton = true
                                            buttonString = "Next Question"
                                            popUpPaneWidth = 1
                                            buttonOffset = 20
                                        } else {
                                            animateMainButton = true
                                            buttonString = "View Results"
                                            checkButtonBorColor = .green
                                            checkButtonColor = .white
                                            popUpPaneWidth = 1
                                            buttonOffset = 20
                                        }
                                    }

                                    if (questionIndex != quiz.count){
                                            answerBorderColor = checkAnswer(quiz[questionIndex].correctAnswer, pressedButton)
                                    } else {return}

                                    if (buttonString == "Next Question" && answerBorderColor == "correct") {
                                        myPlayer.playSong(songFileName: "crct")
                                    } else if (buttonString == "Next Question" && answerBorderColor == "wrong") {
                                        myPlayer.playSong(songFileName: "wrng")
                                        checkButtonColor = .white
                                        checkButtonBorColor = .orange
                                        userDefaults.set(wrongAnswers, forKey: "myKey")
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
                                .frame(width: geometry.size.width * 0.66)
                                .offset(x: -4, y: CGFloat(buttonOffset))
                                
                                if buttonString == "Next Question" {
                                    VStack(alignment: .leading){
                                        if answerBorderColor == "correct" {
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
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("\(title)")
                                    .font(Font.custom("Futura Medium", size: 25))
                                    .foregroundColor(.green.opacity(0.80))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200, height: 20)
                            }
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(quiz: QuizViewModel().quizzesData, title: "Variables", answerBorderColor: "none")
            .environmentObject(QuizViewModel())
    }
}
