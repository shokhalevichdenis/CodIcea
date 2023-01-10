//  Main file.

import SwiftUI

@main
struct _556_GPApp: App {
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
