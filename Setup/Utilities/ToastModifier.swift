//
//  ToastModifier.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    enum _Type {
        case success, error, plain
        
        var color: Color {
            switch self {
            case .success:
                return Color.green
            case .error:
                return Color.red
            case .plain:
                return Color.black
            }
        }
        
        var icon: Image {
            switch self {
            case .success:
                return Image(systemName: "checkmark.circle.fill")
            case .error:
                return Image(systemName: "exclamationmark.triangle.fill")
            case .plain:
                return Image(systemName: "checkmark.circle.fill")
            }
        }
    }
    
    @Binding var isShowing: Bool
    let message: String
    let type: ToastModifier._Type
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                toast
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isShowing.toggle()
                        }
                    }
                }
            }
        }
    }
    
    private var toast: some View {
        VStack {
            HStack {
                type.icon
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.font.medium(16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(type.color)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            Spacer()
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>,
               message: String,
               type: ToastModifier._Type = .error,
               duration: TimeInterval = 3) -> some View {
        modifier(
            ToastModifier(
                isShowing: isShowing,
                message: message,
                type: type,
                duration: duration)
        )
    }
}
