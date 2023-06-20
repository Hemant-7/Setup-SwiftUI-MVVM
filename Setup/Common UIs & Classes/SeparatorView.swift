//
//  SeparatorView.swift
//  Setup
//
//  Created by Hemant kumar on 16/06/23.
//

import SwiftUI

struct SeparatorView: ViewModifier {
    
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var color: Color?
    
    func body(content: Content) -> some View {
        HStack{ Spacer() }
            .frame(width: width, height: height)
            .background(Color.theme.secondaryText)
    }
}

extension View {
    func line(width: CGFloat? = nil, height: CGFloat? = nil, color: Color? = nil) -> some View {
        modifier(SeparatorView(width: width, height: height, color: color))
    }
}

