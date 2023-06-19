//
//  ContentView.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = "Red"
    @State var showingAlert: Bool = false
    let colors = ["Red", "Green", "Blue", "Black"]
    @State var name: String = ""
    @State private var isMenuOpen = false
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack {
                Button {
                    showingAlert.toggle()
                } label: {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                
                //Drop Down
                Picker("Select a paint color", selection: $selection) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Selected color: \(selection)")
                
                CustomTextField(text: $name,
                                title: "Full Name",
                                placeholder: "Enter Name",
                                background: Color.gray.opacity(0.1)
                                
                )
                .onSubmit {
                    validation()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .alert("", isPresented: $showingAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text("Enter name")
        })
    }
    
    func validation() {
        let name = name.trimmingCharacters(in: .whitespaces)
        if name.count < 6 {
            showingAlert.toggle()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
