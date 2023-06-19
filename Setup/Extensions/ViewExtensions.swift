//
//  ViewExtensions.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

// MARK: View Extensions
extension View {
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1.0)
    }
}
