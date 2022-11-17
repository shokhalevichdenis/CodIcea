//
//  V_MainPage.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/16/22.
//

import SwiftUI

struct V_MainPage: View {
    var body: some View {
        NavigationStack{
            NavigationLink {
                V_QuizList()
            } label: {
                MainPageButton(labelValue: "Categories", imageValue: "questionmark")
            }
            
            NavigationLink {
                V_QuizList()
            } label: {
                MainPageButton(labelValue: "Some Other Page", imageValue: "questionmark.folder")
            }
        }
    }
}

struct V_MainPage_Previews: PreviewProvider {
    static var previews: some View {
        V_MainPage()
            .environmentObject(QuizViewModel())
    }
}