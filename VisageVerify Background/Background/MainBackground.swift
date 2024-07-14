//
//  MainBackground.swift
//  VisageVerify Background
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

// a model for a firefly
struct Firefly: Identifiable {
    let id = UUID()
    
    let color:            Color
    let shadowColor:      Color
    let rotationStart:    Double
    let rotationDuration: Double
    let scale:            Double
    let scaleDuration:    Double
    let glow:             Double
    let glowDuration:     Double
    let initialPosition:  CGPoint // CGPoint(x: 10.0, y: 10.0)
}

// a view for a firefly model
struct FireflyView: View {
    // sets random offset and height ratio
    @StateObject var provider = FireflyProvider()
    
    @State var firefly:     Firefly
    @State var move:        Bool   = false
    @State var glowOpacity: Double = 1.0 // initial glow
    @State var scale:       Double = 2.0 // initial scale multiplier
    
    var body: some View {
        Circle()
            // apply a color
            .fill(firefly.color)
        
            // set the size
            .frame(height:
                    UIScreen.main.bounds.height / provider.frameHeightRatio * scale)
            
            // set the offset
            .offset(provider.offset)
        
            // set the rotation
            .rotationEffect(
                .init(
                    degrees: move ?
                    firefly.rotationStart :
                    firefly.rotationStart + 360
                )
            )
        
            // set the limits
            .frame(maxWidth:  .infinity,
                   maxHeight: .infinity)
            
            // set the initial position
            .position(firefly.initialPosition)
        
            // set the initial opacity
            .opacity(glowOpacity)
        
            .shadow(color: firefly.shadowColor, radius: 10)
        
            // start all the animations
            .onAppear {
                startAnimation()
            }
    }
    
    private func startAnimation() {
        // set the rotation animation
        withAnimation(
            Animation.easeOut(
                duration: firefly.rotationDuration
            ).repeatForever(autoreverses: true)
        ){
            move.toggle()
        }
        
        // set the glowing animation
        withAnimation(
            Animation.easeOut(
                duration: firefly.glowDuration
            ).repeatForever(autoreverses: true)
        ){
            glowOpacity = firefly.glow
        }
        
        // set the scaling animation
        withAnimation(
            Animation.easeInOut(
                duration: firefly.scaleDuration
            ).repeatForever(autoreverses: true)
        ){
            scale = firefly.scale
        }
    }
}

// class for randomizing position
class FireflyProvider: ObservableObject {
    let offset:           CGSize
    let frameHeightRatio: CGFloat
    
    init() {
        // take a random number for a screen height divider
        frameHeightRatio = CGFloat.random(in: 10..<30)
        
        // find a random offset
        offset = CGSize(
            width: CGFloat.random(
                in: -UIScreen.main.bounds.width/5..<UIScreen.main.bounds.width/5
            ),
            height: CGFloat.random(
                in: -UIScreen.main.bounds.height/5..<UIScreen.main.bounds.height/5
            )
        )
    }
}

// create a bunch of fireflies
struct FloatingFireflies: View {
    
    @Environment(\.colorScheme) var scheme
    @State private var fireflies: [Firefly] = []
                  
    let quantity: Int
    
    var body: some View {
        ZStack {
            // background color
            Theme.generalBackground(forScheme: scheme)
            
            // put fireflies on screen
            ForEach(fireflies) { firefly in
                FireflyView(firefly: firefly)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            generateFireflies()
        }
    }
    
    // function to generate fireflies
    private func generateFireflies() {
        
        // generate fireflies in a loop
        for _ in 0..<quantity {
            
            let initialPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            )
            
            let firefly = Firefly(
                color:            Theme.FireflyTheme(forScheme: scheme),
                shadowColor:      Theme.shadowTheme(forScheme: scheme),
                rotationStart:    Double.random(in: 0...300),
                rotationDuration: Double.random(in: 10...50),
                scale:            Double.random(in: 1...3),
                scaleDuration:    Double.random(in: 10...50),
                glow:             Double.random(in: 0...1),
                glowDuration:     Double.random(in: 5...20),
                initialPosition:  initialPosition
            )

            fireflies.append(firefly)
        }
    }
}

#Preview {
    FloatingFireflies(quantity: 70)
}
