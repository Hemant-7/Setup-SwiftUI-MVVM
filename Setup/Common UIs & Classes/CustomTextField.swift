//
//  CustomTextField.swift
//  Setup
//
//  Created by Hemant kumar on 16/06/23.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var title: String? = nil
    var placeholder: String
    var suffixImage: String? = nil
    var background: Color = .clear
    var keyboardType: UIKeyboardType = .default
    var isSecuredTextEntry: Bool  = false
    var disabled: Bool = false
    @State private var showText: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.font.bold(14))
            }
            VStack {
                HStack {
                    if !isSecuredTextEntry {
                        TextField(placeholder,text: $text)
                            .font(.font.regular(14))
                            .keyboardType(keyboardType)
                            .disabled(disabled)
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 8)
                        
                    } else {
                        if showText {
                            SecureField(placeholder, text: $text)
                                .font(.font.regular(14))
                                .keyboardType(keyboardType)
                                .disabled(disabled)
                                .textInputAutocapitalization(.never)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                            
                        } else {
                            TextField(placeholder,text: $text)
                                .font(.font.regular(14))
                                .keyboardType(keyboardType)
                                .disabled(disabled)
                                .textInputAutocapitalization(.never)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                        }
                    }
                    if let suffixImage = suffixImage {
                        Image(suffixImage)
                            .resizable()
                            .frame(width: 10, height: 6)
                            .padding(.trailing, 12)
                    }
                    if isSecuredTextEntry {
                        Button {
                            showText.toggle()
                        } label: {
                            Image(systemName: showText ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(Color.theme.secondaryText)
                                .padding(.top, 8)
                        }
                        .padding(.trailing, 16)
                    }
                }
                EmptyView()
                    .line(height: 1)
            }
            .background(background)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Name"), placeholder: "Enter")
    }
}
