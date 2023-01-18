//  Splash screen.

import SwiftUI

struct V_SplashScreen: View {
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var offsetY: CGFloat = 15
    
    // Changes size and opcacity for animation.
    func animateSplash() {
        withAnimation(.easeIn(duration: 1.8)) {
            self.size = 0.9
            self.opacity = 1.0
        }
    }
    
    var body: some View {
        // Sends to the main page after the splash.
        if isActive {
            ContentView()
        } else {
            ZStack {
                Group {
                    Group {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 53))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            animateSplash()
                        }
                    }
                    Group {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 53))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                    .offset(y: offsetY)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            animateSplash()
                            self.offsetY = 0
                        }
                    }
                    Group {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 53))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                    .offset(y: -offsetY)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            animateSplash()
                        }
                    }
                }
                .scaleEffect(size)
                .opacity(opacity)
                .frame(width: 29)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
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

