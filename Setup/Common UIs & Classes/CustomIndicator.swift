//
//  CustomIndicator.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct CustomIndicator: View {
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            Image ("Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame (width: 64, height: 64)
            Circle ()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5: 1)
                .stroke(lineWidth: 7)
                .rotationEffect(
                    .degrees (isCircleRotating ? 360 : 0))
                .frame (width: 80, height: 80)
                .foregroundColor(Color.blue)
                .onAppear() {
                    withAnimation(Animation
                        .linear (duration: 1)
                        .repeatForever(autoreverses: false)) {
                            self.isCircleRotating.toggle()
                        }
                    withAnimation(Animation
                        .linear (duration: 1)
                        .delay (0.5)
                        .repeatForever(autoreverses: true)) {
                            self.animateStart.toggle()
                        }
                    withAnimation(Animation
                        .linear (duration: 1)
                        .delay (1)
                        .repeatForever(autoreverses:true)) {
                            self.animateEnd.toggle()
                        }
                }
        }
        .ignoresSafeArea()
    }
}
