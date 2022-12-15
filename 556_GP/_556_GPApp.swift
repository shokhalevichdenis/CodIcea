//
//  _556_GPApp.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 10/8/22.
//

import SwiftUI

@main
struct _556_GPApp: App {
    @StateObject private var quizData = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                V_SplashScreen()
                    .environmentObject(quizData)
            }
        }
    }
}
