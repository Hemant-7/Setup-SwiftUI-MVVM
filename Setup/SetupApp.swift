//
//  SetupApp.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

@main
struct SetupApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            
            NavigationStack {
                if let _ = UserObject().getObject(forKey: UserObject.Constants.token) as? String {
                    HomeView(viewModel: HomeViewModel())
                } else {
                    LoginView(viewModel: LoginViewModel())
                }
            }
        }
    }
}
