//
//  V_MainPage.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/16/22.
//

import SwiftUI

struct V_MainPage: View {
    @Binding var lWrongAnswersForPlot: [[Int]]
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("What's your pleasure?")
                    .font(Font.custom("Futura Medium", size: 23))
                    .multilineTextAlignment(.leading)
                ScrollView{
                    NavigationLink {
                        V_QuizList(chosenLanguage: "Swift", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "Swift", imageValue: "swift")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "JavaScript", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "JavaScript", imageValue: "heart.fill")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "Python", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "Python", imageValue: "scribble")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "C#", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "C#", imageValue: "number")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "C++", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "C++", imageValue: "plusminus")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "PHP", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "PHP", imageValue: "figure.fall")
                    }
                    NavigationLink {
                        V_QuizList(chosenLanguage: "Java", lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    } label: {
                        StartPageButton(labelValue: "Java", imageValue: "cup.and.saucer")
                    }
                }
                .scrollIndicators(.hidden)
                Spacer()
            }
            .navigationTitle("Languages")
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
        .accentColor(.black)
    }
}

//TODO: Move to the Reusable UI

// Menu buttons for start page
struct StartPageButton: View {
    var labelValue: String
    var imageValue: String
    
    var body: some View {
        VStack{
            Image(systemName: imageValue)
                .foregroundColor(.black)
                .frame(width: 35, height: 35)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 1)
            Text(labelValue)
                .font(Font.custom("Futura Medium", size: 18))
                .foregroundColor(.black)
        }
        .frame(width: 300, height: 100)
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(LinearGradient(gradient: Gradient(colors: [.green, Color("LightGray"), .green]), startPoint: .topLeading, endPoint: .bottomTrailing), style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
        )
        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        .padding(.bottom, 7)
    }
}

struct V_MainPage_Previews: PreviewProvider {
    static var previews: some View {
        V_MainPage(lWrongAnswersForPlot: Binding.constant([[0,0]]))
            .environmentObject(QuizViewModel())
    }
}
