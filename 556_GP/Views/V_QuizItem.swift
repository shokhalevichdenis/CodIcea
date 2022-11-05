//
//  V_Layout.swift
//  556_GP
//
//  Single category item for a list
//

import SwiftUI

struct V_QuizItem: View {
    var category: String
    
    var body: some View {
        HStack{
            Text(category)
        }
    }
}

struct V_QuizItem_Previews: PreviewProvider {
    static var previews: some View {
        V_QuizItem(category: "fsdfs")
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
