//
//  FirstAppear.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import SwiftUI

private struct FirstAppear: ViewModifier {

    // MARK: - Variables
    let firstAppearAction: () -> Void
    @State private var appearedFirstTime: Bool = true

    // MARK: - Method
    func body(content: Content) -> some View {
        content.onAppear {
            if appearedFirstTime {
                appearedFirstTime = false
                firstAppearAction()
            }
        }
    }
}

extension View {
    func onFirstAppear(firstAppearAction: @escaping() -> Void) -> some View {
        return self.modifier(FirstAppear(firstAppearAction: firstAppearAction))
    }
}
