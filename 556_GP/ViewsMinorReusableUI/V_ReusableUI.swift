//
//  Styles.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/16/22.
//

import SwiftUI

// Main button for quiz page (V_SlideCardStack)
struct MainButtonStyle: ButtonStyle {
    var color: Color
    var textColor: Color
    var borderColor: Color
    
    public func makeBody(configuration: MainButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(textColor)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 15).fill(color))
            .cornerRadius(15)
            .border(borderColor, width: 2)
            .compositingGroup()
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}


// Menu buttons for start page
struct StartPageButton: View {
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
