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

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(question.question)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Spacer()
            
            VStack(alignment: .leading){
                
                ForEach(question.answers) { answer in
                    Button(action: {
                        pressedButton = answer.id
                        
                    })
                    {
                        Text(answer.answer)
                            .multilineTextAlignment(.leading)
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(setColor(question.correctAnswer, answer.id, pressedButton))
                            .cornerRadius(12)
                            .shadow(radius: 3)
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

struct V_SlideCard_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCard(question: quizzes[0], pressedButton: .constant(Int(0)))
    }
}
