//
//  Color.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let background = Color("background")
    let cyan = Color("cyan")
    let primaryText = Color("primaryText")
    let secondaryText = Color("secondaryText")
    let tertiaryText = Color("tertiaryText")
}
