//  Main file.

import SwiftUI

@main
struct Codicea: App {
    @StateObject private var quizData = QuizViewModel()
    @State var lWrongAnswersForPlot: [[Int]] = wrongAnswersForPlot
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                V_SplashScreen(lWrongAnswersForPlot: $lWrongAnswersForPlot)
                    .environmentObject(quizData)
            }
        }
    }
}