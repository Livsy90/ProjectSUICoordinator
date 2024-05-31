//
//  AuroraView.swift
//
//
//  Created by Livsy on 13.05.2024.
//

import SwiftUI

private enum Colors {
    static var all: [Color] {
        [
            Color.red,
            Color.pink,
            Color.blue,
            Color.purple,
            Color.indigo,
        ]
    }
    
    static var backgroundColor: Color {
        Color(
            red: 23/255,
            green: 81/255,
            blue: 104/255
        )
    }
}

struct DynamicGradientView: View {
    
    private enum Animation {
        static let speed: Double = 3
        static let timerDuration: TimeInterval = 2
        static let blurRadius: CGFloat = 130
    }
    
    @ObservedObject private var animator = CircleAnimator(colors: Colors.all)
    @State private var timer = Timer.publish(
        every: Animation.timerDuration,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(animator.circles) { circle in
                    CircleShape(originOffset: circle.position)
                        .foregroundColor(circle.color)
                }
            }.blur(radius: Animation.blurRadius)
        }
        .background(Colors.backgroundColor)
        .onDisappear {
            timer.upstream.connect().cancel()
        }
        .onAppear {
            animateCircles()
            timer = Timer.publish(
                every: Animation.timerDuration,
                on: .main,
                in: .common
            ).autoconnect()
        }
        .onReceive(timer) { _ in
            animateCircles()
        }
    }
    
    private func animateCircles() {
        withAnimation(.easeInOut(duration: Animation.speed)) {
            animator.animate()
        }
    }
    
}

private struct CircleShape: Shape {
    
    var originOffset: CGPoint
    
    var animatableData: CGPoint.AnimatableData {
        get {
            originOffset.animatableData
        }
        set {
            originOffset.animatableData = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let adjustedX = rect.width * originOffset.x
        let adjustedY = rect.height * originOffset.y
        let smallestDimension = min(rect.width, rect.height)

        path.addArc(
            center: CGPoint(x: adjustedX, y: adjustedY),
            radius: smallestDimension / 2,
            startAngle: .zero,
            endAngle: .degrees(360),
            clockwise: true
        )
        
        return path
    }
}

private class CircleAnimator: ObservableObject {
    final class Circle: Identifiable {
        internal init(position: CGPoint, color: Color) {
            self.position = position
            self.color = color
        }
        var position: CGPoint
        let id = UUID().uuidString
        let color: Color
    }
    
    @Published private(set) var circles: [Circle] = []
    
    
    init(colors: [Color]) {
        circles = colors.map({ color in
            Circle(
                position: CircleAnimator.generateRandomPosition(),
                color: color
            )
        })
    }
    
    func animate() {
        objectWillChange.send()
        for circle in circles {
            circle.position = CircleAnimator.generateRandomPosition()
        }
    }
    
    static func generateRandomPosition() -> CGPoint {
        CGPoint(
            x: CGFloat.random(in: 0 ... 1),
            y: CGFloat.random(in: 0 ... 1)
        )
    }
}
