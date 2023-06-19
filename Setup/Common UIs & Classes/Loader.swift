//
//  CustomAlert.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct Loader: ViewModifier {
    
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack { content
            if isShowing {
                CustomIndicator()
            }
        }
    }
}

extension View {
    func indicator(isShowing: Binding<Bool>) -> some View {
        modifier(
            Loader(isShowing: isShowing)
        )
    }
}
