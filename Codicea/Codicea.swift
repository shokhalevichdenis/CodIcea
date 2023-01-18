//  Main file.

import SwiftUI

@main
struct Codicea: App {
    @StateObject private var dataController = DataController()
    @StateObject private var quizData = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                V_SplashScreen()
                    .environmentObject(quizData)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}
