//
//  V_ResultsPage.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 12/14/22.
//

import SwiftUI

struct V_ResultsPage: View {
    var wrongAnswers: Int = 0
    var localCorrectAnswers: Int = 0
    var localSkippedAnswers: Int = 0
    
    var body: some View {
        
        NavigationStack {
            VStack{
                Text("Your Results")
                    .font(Font.custom("Futura Medium", size: 23))
                    .multilineTextAlignment(.leading)
                Spacer()
                VStack{
                    Text("\(localCorrectAnswers)")
                        .foregroundColor(.green.opacity(0.80))
                        .font(Font.custom("Futura Medium", size: 80))
                    Text("Correct Answers")
                }.padding(.bottom,20)

                HStack{
                    Spacer()
                    VStack{
                        Text("\(wrongAnswers)")
                            .foregroundColor(.red.opacity(0.80))
                            .font(Font.custom("Futura Medium", size: 46))
                        Text("Wrong")
                    }
                    Spacer()
                    VStack{
                        Text("\(localSkippedAnswers)")
                            .foregroundColor(.gray.opacity(0.80))
                            .font(Font.custom("Futura Medium", size: 46))
                        Text("Skipped")
                    }
                    Spacer()
                }
//                Divider()
                Spacer()
                Spacer()
            }
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 25))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 20)
                    }
                }
            }
        }
        
    }
}

struct V_ResultsPage_Previews: PreviewProvider {
    static var previews: some View {
        V_ResultsPage()
    }
}
