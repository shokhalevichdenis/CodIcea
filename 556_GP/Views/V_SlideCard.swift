//
//  V_SlideCard.swift
//  556_GP
//
//  View of a single question card
//

import SwiftUI

struct V_SlideCard: View {
    var question: Quiz
    @Binding var pressedButton: Int
    @State var buttonBgColor: Color = .white
    @State var buttonIsDisabled: Bool = true
    @State var buttonString: String = "Check"

    var body: some View {
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
       
            Button {
                buttonBgColor = setColor(question.correctAnswer, pressedButton)
                buttonString = "Explanation"
            } label: {
                Spacer()
                Text(buttonString)
                Spacer()
            }
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .frame(width: .infinity, alignment: .center)
            .disabled(buttonIsDisabled)
        }
    }
}

struct V_SlideCard_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCard(question: QuizViewModel().quizzesData[0], pressedButton: .constant(Int(0)))
    }
}
