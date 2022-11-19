//
//  SwiftUIView.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/18/22.
//

import SwiftUI


struct SwiftUIView: View {
    var animationDuration: Double = 0.75
    @State private var innerTrimEnd: CGFloat = 0
    @State private var strokeColor = Color.blue
    @State private var scale = 1.0
    var shouldScale = true
    var size: CGSize = .init(width: 300, height: 300)
    var innerShapeSizeRatio: CGFloat = 1/3
    var strokeStyle: StrokeStyle = .init(lineWidth: 24, lineCap: .round, lineJoin: .round)
    
    func animate() {
        if shouldScale {
            withAnimation(.linear(duration: 0.4 * animationDuration)) {
                outerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.4 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.7 * animationDuration)
            ) {
                strokeColor = .green
                scale = 1.1
            }
            
            withAnimation(
                .linear(duration: 0.1 * animationDuration)
                .delay(0.9 * animationDuration)
            ) {
                scale = 1
            }
        } else {
            withAnimation(.linear(duration: 0.5 * animationDuration)) {
                outerTrimEnd = 1.0
            }
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.5 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.8 * animationDuration)
            ) {
                strokeColor = .green
            }
        }
    }
    
    struct Checkmark: Shape {
        func path(in rect: CGRect) -> Path {
            let width = rect.size.width
            let height = rect.size.height
            
            var path = Path()
            path.move(to: .init(x: 0 * width, y: 0.5 * height))
            path.addLine(to: .init(x: 0.4 * width, y: 1.0 * height))
            path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
            return path
        }
    }
    
    @State private var outerTrimEnd: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .rotationEffect(.degrees(-90))
            Checkmark()
                .trim(from: 0, to: innerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .frame(width: size.width * innerShapeSizeRatio, height: size.height * innerShapeSizeRatio)
        }
        .onAppear() {
            animate()
        }
        .onTapGesture {
            outerTrimEnd = 0
            innerTrimEnd = 0
            strokeColor = .blue
            animate()
            scale = 1
        }
        .scaleEffect(scale)
        .frame(width: size.width, height: size.height)
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}