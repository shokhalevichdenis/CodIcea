//
//  SwiftUIView.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/18/22.
//

import SwiftUI


struct V_CheckMarkIcon: View {
    var animationDuration: Double = 0.75
    @State private var innerTrimEnd: CGFloat = 0
    @State private var strokeColor = Color.gray
    @State var answerStrokeColor: Color
    @State private var scale = 1.0
    @State private var strokeStyle: StrokeStyle = .init(lineWidth: 2, lineCap: .round, lineJoin: .round)
    @State private var size: CGSize = .init(width: 25, height: 25)
    @State private var innerShapeSizeRatio: CGFloat = 1/3
    
    
    func animate() {
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
            strokeColor = answerStrokeColor
            scale = 1.1
        }
        
        withAnimation(
            .linear(duration: 0.1 * animationDuration)
            .delay(0.9 * animationDuration)
        ) {
            scale = 1
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
    
    struct Cross: Shape {
        func path(in rect: CGRect) -> Path {
            let width = rect.size.width
            let height = rect.size.height
            
            var path = Path()
            path.move(to: .init(x: 0 * width, y: 1 * height))
            path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
            return path
        }
    }
    
    @State private var outerTrimEnd: CGFloat = 0
    var body: some View {
        Group {
            if (answerStrokeColor == .green) {
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
                .scaleEffect(scale)
                .frame(width: size.width, height: size.height)
            }
            else {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: outerTrimEnd)
                        .stroke(strokeColor, style: strokeStyle)
                        .rotationEffect(.degrees(-90))
                    Cross()
                        .trim(from: 0, to: innerTrimEnd)
                        .stroke(strokeColor, style: strokeStyle)
                        .frame(width: size.width * innerShapeSizeRatio, height: size.height * innerShapeSizeRatio)
                }
                .onAppear() {
                    animate()
                }
                .scaleEffect(scale)
                .frame(width: size.width, height: size.height)
                
            }

        }
        
    }
}

struct V_CheckMarkIcon_Previews: PreviewProvider {
    static var previews: some View {
        V_CheckMarkIcon(answerStrokeColor: .green)
    }
}

