//
//  Styles.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/16/22.
//

import SwiftUI

//struct mainPageButton: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(.black)
//            .frame(width: 35, height: 35)
//            .background(.white)
//            .clipShape(Circle())
//            .shadow(color: .blue, radius: 1)
//    }
//}

// Buttons for main page
struct MainPageButton: View {
    var labelValue: String
    var imageValue: String
    
    var body: some View {
        Image(systemName: imageValue)
            .foregroundColor(.black)
            .frame(width: 35, height: 35)
            .background(.white)
            .clipShape(Circle())
            .shadow(color: .blue, radius: 1)
        Text(labelValue)
    }
}

// A row for the categories list
struct V_QuizItem: View {
    var category: String
    
    var body: some View {
        HStack{
            Text(category)
        }
    }
}
