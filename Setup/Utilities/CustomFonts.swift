//
//  CustomFonts.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation
import SwiftUI

struct CustomFonts {
    
    static let shared = CustomFonts()
    
    private init() {}
    
    func black(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Black", size: size)
    }
    
    func blackItalic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-BlackItalic", size: size)
    }
    
    func bold(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Bold", size: size)
    }
    
    func boldItalic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-BoldItalic", size: size)
    }
    
    func italic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Italic", size: size)
    }
    
    func light(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Light", size: size)
    }
    
    func lightItalic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-LightItalic", size: size)
    }
    
    func medium(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Medium", size: size)
    }
    
    func mediumItalic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-MediumItalic", size: size)
    }
    
    func regular(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Regular", size: size)
    }
    
    func thin(_ size: CGFloat) -> Font {
        Font.custom("Roboto-Thin", size: size)
    }
    
    func thineItalic(_ size: CGFloat) -> Font {
        Font.custom("Roboto-ThinItalic", size: size)
    }
}

extension Font {
    static let font = CustomFonts.shared
}
