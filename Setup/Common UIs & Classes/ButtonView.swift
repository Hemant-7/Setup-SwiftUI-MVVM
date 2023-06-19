//
//  ButtonView.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import SwiftUI

struct ButtonView: View {
    
    let title: String
    let callback: (() -> Void)
    
    init(title: String, isLocked: Bool = false, callback: @escaping () -> Void) {
        self.title = title
        self.callback = callback
    }
    
    var body: some View {
        Button {
            callback()
        } label: {
            HStack(spacing: 4) {
                Spacer()
                Text(title)
                    .font(.font.bold(16))
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.theme.cyan)
                    .shadow(radius: 5, x: 2, y: 2)
            )
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "CHECK POSTURE") {
            
        }
    }
}
