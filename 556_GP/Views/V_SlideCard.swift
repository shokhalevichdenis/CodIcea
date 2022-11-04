//
//  V_SlideCard.swift
//  556_GP
//
//  View of a single quiz card
//

import SwiftUI

struct V_SlideCard: View {
    var quiz: Quiz
    @State var pressedButton: Int = 0
    @State var check: Int = 0
// TODO: Check APIs
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(quiz.question)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Spacer()
            
            VStack(alignment: .leading){
                
                ForEach(quiz.answers) { answer in
                    Button(action: {
                        pressedButton = answer.id
                        check = 1
                    })
                    {
                        Text(answer.answer)
                            .multilineTextAlignment(.leading)
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(setColor(quiz.correctAnswer, answer.id, pressedButton, check))
                            .border(.gray, width: 0.3)
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
