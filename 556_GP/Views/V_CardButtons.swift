//
//  SwiftUIView.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/18/22.
//

import SwiftUI


struct V_CardButtons: View {
    var animationDuration: Double = 0.40
    @State var strokeColor: Color = Color("LightGray2")
    @State var outerTrimEnd: CGFloat = 1
    @Binding var shouldAnimate: String
    @State var text: String = ""
    
    var strokeStyle: StrokeStyle = .init(lineWidth: 2, lineCap: .round, lineJoin: .round)
    
    func animate() {
        withAnimation(.linear(duration: 0.7 * animationDuration)) {
            strokeColor = strokeColor
            outerTrimEnd = 1.0
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .multilineTextAlignment(.leading)
                .padding()
            RoundedRectangle(cornerRadius: 20)
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
        }
        .contentShape(Rectangle())
        .frame(width: nil, height: nil)
        .ignoresSafeArea()
        .onChange(of: shouldAnimate) {newvalue in
            if (strokeColor == Color("LightGray3") && shouldAnimate == "correct") {
                strokeColor = .green
                outerTrimEnd = 0
                animate()
            }
            else if(strokeColor == Color("LightGray3") && shouldAnimate == "wrong")  {
                strokeColor = .red
                outerTrimEnd = 0
                animate()
            }
        }
    }
}


struct V_CardButtons_Previews: PreviewProvider {
    static var previews: some View {
        V_CardButtons(shouldAnimate: Binding.constant("none"))
    }
}
