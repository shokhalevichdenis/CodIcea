//
//  V_SplashScreen.swift
//  556_GP
//
//  Splash screen for the application.
//

import SwiftUI

struct V_SplashScreen: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var color: Color = .white
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            V_MainPage()
        } else {
            VStack {
                VStack {
                    Image(systemName: "swift")
                        .font(.system(size: 160))
                    
                    Text("")
//                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                        .multilineTextAlignment(.center)
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .foregroundColor(color)
                .frame(width: 29)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                        self.color = .black
                        
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct V_SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        V_SplashScreen()
    }
}

