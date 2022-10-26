//
//  V_SlideCard.swift
//  556_GP
//
//  View of a single quiz card
//

import SwiftUI

struct V_SlideCard: View {
//    @EnvironmentObject var modelData: ModelData
    var quiz: Quiz
    @State private var answerCorrect: Int = 0
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(quiz.question)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Spacer()
            
            VStack(alignment: .leading){
                
                ForEach(quiz.answers) { answer in
                    Button(action: {
                        guard answerCorrect == 0 else {return}
                        answer.id == quiz.correctAnswer ? (answerCorrect = answer.id) : (answerCorrect = 9)
//                    TODO: ADD an image overlay instead of changing color of the buttons 
                    })
                    {
                        Text(answer.answer)
                            .multilineTextAlignment(.leading)
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(answerCorrect == answer.id ? Color.green : setColor(answerCorrect, answer.id))
                            .border(.gray, width: 0.5)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
            }
            .font(.body)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
            
        }
        .padding()
        .background(Color.blue)
        
    }
}

struct V_SlideCard_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCard(quiz: quizzes[0])
    }
}
