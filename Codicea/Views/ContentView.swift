// Main view with tabs menu.

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            TabView() {
                V_MainPage()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                V_ReviewPage()
                    .tabItem {
                        Label("Review", systemImage: "exclamationmark.arrow.circlepath")
                    }

            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(QuizViewModel())
        
    }
}


