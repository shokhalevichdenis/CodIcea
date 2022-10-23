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
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(quiz.question)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            VStack(alignment: .leading){
                
                ForEach(quiz.answers) { answer in
                    Button(action: {
                        
                    })
                    {
                        Text(answer.answer)
                            .multilineTextAlignment(.leading)
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(.white)
                            .border(.yellow)
                            .cornerRadius(12)
                    }
                }
            }
            .font(.body)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
        .background(.gray)
        
    }
}

struct V_SlideCard_Previews: PreviewProvider {
    static var previews: some View {
        V_SlideCard(quiz: quizzes[0])
    }
}
