//  Quiz page.

import SwiftUI
import Foundation

// Access Shared Defaults Object
let userDefaults = UserDefaults.standard
var wrongAnswersForPlot: [[Int]] = userDefaults.object(forKey: "forPlot") as? [[Int]] ?? [[0,0]]
// Initialize Player
var myPlayer = AudioPlayer();

struct V_SlideCardStack: View {
    @Binding var lWrongAnswersForPlot: [[Int]]
    @EnvironmentObject var quizData: QuizViewModel
    
    @State private var iterator: Int = 0 // To iterate through questions.
    @State private var questionIndex: Int = 0 // Question index.
    @State var progressBarWidth = 0.0
    @State var quiz: [Quiz] // Stores Quiz data.
    @State var title: String // Page title.
    @State var pressedButton: Int = 0 // ID of a button that was pressed.
    @State var animateMainButton: Bool = false
    @State var checkButtonIsDisabled: Bool = true
    @State var checkButtonString: String = "Check" // The text inside the main button.
    @State var checkButtonColor: Color = Color("LightGray") // The main button background.
    @State var checkButtonBorColor: Color = Color("LightGray2") // The main button border color.
    @State var checkButtonFColor: Color = Color("LightGray3") // The main button text color.
    @State var checkButtonOffset = 0 // Offest of the main button.
    @State var answerBorderColor: String = "none" // Answer buttons color.
    @State var popUpPaneWidth: Int = 0
    
    // Variables holding staistics of an attempted quiz.
    @State var wrongAnswers: [Int] = userDefaults.object(forKey: "myKey") as? [Int] ?? [] // Stores wrong answers locally.
    @State var localWrongAnswers: [Int] = []
    @State var localCorrectAnswers: Int = 0
    @State var localSkippedAnswers: Int = 0
    
    // Next question.
    func nextQuestion() {
        questionIndex < (quiz.count - 1) ? (questionIndex += 1) : (questionIndex = quiz.count)
        // Assigning questions' ids, so TabView selector can safely iterate through them
        if !(questionIndex == quiz.count) {
            iterator = quiz[questionIndex].id
        }
        pressedButton = 0
        checkButtonIsDisabled = true
    }
    
    // Change button options.
    func changeButtonSettings(_ ppWidth: Int, _ cbOffset: Int, _ cbString: String, _ amButton: Bool) {
        popUpPaneWidth = ppWidth
        checkButtonOffset = cbOffset
        checkButtonString = cbString
        animateMainButton = amButton
    }
    
    var body: some View {
        VStack {
            if !(questionIndex == quiz.count) {
                GeometryReader {geometry in
                    VStack(spacing: 0){
                        NavigationStack {
                            VStack(spacing: 0){
                                
                                // Draws progress bar.
                                HStack(spacing: 0){
                                    Path{ path in
                                        path.move(to: CGPoint(x: 0, y: 10))
                                        path.addLine(to: CGPoint(x: progressBarWidth, y: 10))
                                    }
                                    .stroke(RadialGradient(gradient: Gradient(colors: [.green.opacity(0.8), .clear]), center: .center, startRadius: 2, endRadius: 620), lineWidth: 20)
                                    .background(RadialGradient(gradient: Gradient(colors: [Color("LightGray"), .clear]), center: .center, startRadius: 80, endRadius: 200))
                                    .frame(width: geometry.size.width * 0.8, height: 20)
                                    .cornerRadius(12)
                                    .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
                                    Text("\(questionIndex+1)/\(quiz.count)")
                                        .frame(width: geometry.size.width * 0.12, alignment: .trailing)
                                        .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
                                }
                                // Displaying questions and answers
                                TabView(selection: $iterator) {
                                    ForEach(quiz) { question in
                                        VStack{
                                            VStack(alignment: .leading, spacing: 0) {
//                                                Text(question.question)
                                                V_QuestionWebView(question: question.question)
                                                                                                    
                                                Spacer()
                                                VStack(alignment: .center){
                                                    ForEach(question.answers) { answer in
                                                        Button {
                                                            pressedButton = answer.id
                                                            checkButtonIsDisabled = false
                                                            checkButtonColor = .green.opacity(0.8)
                                                            checkButtonBorColor = .green
                                                            checkButtonFColor = .black
                                                            answerBorderColor = "none"
                                                            myPlayer
                                                        } label: {
                                                            if (answer.id == pressedButton) {
                                                                V_CardButtons(strokeColor: Color("LightGray3"), answerBorderColor: $answerBorderColor, text: answer.answer)
                                                            } else if (pressedButton != answer.id) {
                                                                V_CardButtons(answerBorderColor: $answerBorderColor, text: answer.answer)
                                                            }
                                                        }
                                                    }
                                                }
                                                .disabled(checkButtonString == "Next Question" ? true : false)
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
                                .animation(.easeIn(duration: 0.0), value: iterator)
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .onAppear{
                                    // Assigning initial value to iterator.
                                    iterator = quiz[questionIndex].id
                                    progressBarWidth += ((Double(geometry.size.width) * 0.8) / (Double(quiz.count)))
                                }
                                
                            }
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        }
                        
                        // "Skip" and the main buttons.
                        HStack {
                            if !animateMainButton {
                                Button {
                                    nextQuestion()
                                    progressBarWidth += ((Double(geometry.size.width) * 0.8) / (Double(quiz.count)))
                                    localSkippedAnswers += 1
                                    checkButtonIsDisabled = true
                                    
                                    checkButtonColor = Color("LightGray")
                                    checkButtonBorColor = Color("LightGray2")
                                    checkButtonFColor = Color("LightGray3")
                                    if (questionIndex == quiz.count - 1) {
                                        wrongAnswersForPlot.append([
                                            wrongAnswersForPlot[wrongAnswersForPlot.count-1][0] + 1,
                                            localWrongAnswers.count])
                                        
                                        userDefaults.set(wrongAnswersForPlot, forKey: "forPlot")
                                        lWrongAnswersForPlot = wrongAnswersForPlot
                                        lWrongAnswersForPlot.append([
                                            wrongAnswersForPlot[lWrongAnswersForPlot.count-1][0] + 1,
                                            localWrongAnswers.count])
                                    } else {return}
                                    
                                } label: {
                                    Text("Skip >>")
                                }
                                .buttonStyle(MainButtonStyle(color: .white, textColor: .black, borderColor: .black.opacity(0.8)))
                                .frame(width: geometry.size.width * 0.3)
                                .offset(x: -8)
                            } else {
                                EmptyView()
                            }
                            
                            // The button panel and the main button.
                            ZStack {
                                Button {
                                    if (checkButtonString == "Next Question") {
                                        progressBarWidth += ((Double(geometry.size.width) * 0.8) / (Double(quiz.count)))
                                        checkButtonIsDisabled = true
                                        checkButtonColor = Color("LightGray")
                                        checkButtonBorColor = Color("LightGray2")
                                        checkButtonFColor = Color("LightGray3")
                                        changeButtonSettings(0, 0, "Check", false)
                                        nextQuestion()
                                    } else if (checkButtonString == "View Results") {
                                        wrongAnswersForPlot.append([
                                            wrongAnswersForPlot[wrongAnswersForPlot.count-1][0] + 1,
                                            localWrongAnswers.count])
                                        
                                        userDefaults.set(wrongAnswersForPlot, forKey: "forPlot")
                                        lWrongAnswersForPlot = wrongAnswersForPlot
                                        lWrongAnswersForPlot.append([
                                            wrongAnswersForPlot[lWrongAnswersForPlot.count-1][0] + 1,
                                            localWrongAnswers.count])
                                        nextQuestion()
                                    } else {
                                        if (questionIndex < quiz.count - 1) {
                                            changeButtonSettings(1, 20, "Next Question", true)
                                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                            impactMed.impactOccurred()
                                        } else {
                                            localWrongAnswers.append(quiz[questionIndex].id)
                                            changeButtonSettings(1, 20, "View Results", true)
                                            checkButtonBorColor = .green.opacity(0.8)
                                            checkButtonColor = .white
                                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                            impactMed.impactOccurred()
                                        }
                                    }
                                    
                                    if (questionIndex != quiz.count){
                                        answerBorderColor = checkAnswer(quiz[questionIndex].correctAnswer, pressedButton)
                                    } else {return}
                                    
                                    if (checkButtonString == "Next Question" && answerBorderColor == "correct") {
                                        myPlayer.playSong(songFileName: "crct")
                                        localCorrectAnswers += 1
                                    } else if (checkButtonString == "Next Question" && answerBorderColor == "wrong") {
                                        myPlayer.playSong(songFileName: "wrng")
                                        checkButtonColor = .white
                                        checkButtonBorColor = .orange.opacity(0.8)
                                        localWrongAnswers.append(quiz[questionIndex].id)
                                        
                                        // Saving unique wrong answers
                                        var isDuplicate = false
                                        for id in wrongAnswers {
                                            if (id == quiz[questionIndex].id) {
                                                isDuplicate = true
                                            } else {continue}
                                        }
                                        if !isDuplicate {
                                            wrongAnswers.append(quiz[questionIndex].id)
                                        } else {return}
                                        userDefaults.set(wrongAnswers, forKey: "myKey")
                                    }
                                    
                                } label: {
                                    HStack{
                                        Spacer()
                                        Text(checkButtonString)
                                        Spacer()
                                    }
                                }
                                .disabled(checkButtonIsDisabled)
                                .buttonStyle(MainButtonStyle(color: checkButtonColor, textColor: checkButtonFColor, borderColor: checkButtonBorColor))
                                .frame(width: geometry.size.width * 0.66)
                                .offset(x: -4, y: CGFloat(checkButtonOffset))
                                
                                // Displaying icons indicating correct or wrong answer/
                                if checkButtonString == "Next Question" {
                                    VStack(alignment: .leading){
                                        if answerBorderColor == "correct" {
                                            Group {
                                                Text("Correct!")
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 25)
                                                V_CheckMarkIcon(animationDuration: 0.4, answerStrokeColor: .green.opacity(0.8))
                                                    .padding(.init(top: -9, leading: -9, bottom: 0, trailing: 0))
                                            }
                                            .padding(-45) }
                                        else {
                                            Group {
                                                Text("Wrong!")
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 28)
                                                V_CheckMarkIcon(animationDuration: 0.4, answerStrokeColor: .red.opacity(0.8))
                                                    .padding(.init(top: -9, leading: -8, bottom: 0, trailing: 0))
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
                            VStack {
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
                V_ResultsPage(lWrongAnswersForPlot: $lWrongAnswersForPlot, wrongAnswers: localWrongAnswers.count, localCorrectAnswers: localCorrectAnswers, localSkippedAnswers: localSkippedAnswers, quiz: quiz, title: title)
            }
        }
    }
}

struct V_SlideCardStack_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCardStack(lWrongAnswersForPlot: Binding.constant([[0,0]]), quiz: QuizViewModel().quizzesData, title: "Variables", answerBorderColor: "none")
            .environmentObject(QuizViewModel())
    }
}
