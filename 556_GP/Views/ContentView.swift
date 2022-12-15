//
//  ContentView.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 12/12/22.
//

import SwiftUI


struct ContentView: View {
    @Binding var lWrongAnswersForPlot: [[Int]]

    var body: some View {
        NavigationStack{
            TabView() {
                V_MainPage(lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                V_ReviewPage(lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    .tabItem {
                        Label("Review", systemImage: "exclamationmark.arrow.circlepath")
                    }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(lWrongAnswersForPlot: Binding.constant([[0,0]]))
            .environmentObject(QuizViewModel())
    }
}


