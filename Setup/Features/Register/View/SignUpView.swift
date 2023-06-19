//
//  SignUpView.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SignUpViewModel
        
    var body: some View {
        ZStack {
            Color.theme.background
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    title
                    loginInput
                    loginButton
                }
                .padding(24)
            }
        }
        .indicator(isShowing: $viewModel.isLoading)
        .toast(isShowing: $viewModel.showAlert, message: viewModel.alertMessage, type: viewModel.alertType)
        
    }
    
    /// Title
    private var title: some View {
        Text("SIGN UP")
            .font(.font.bold(40))
            .padding(.vertical, 50)
        
    }
    
    /// User Login email and
    ///  User Password
    private var loginInput: some View {
        VStack(spacing: 20) {
            CustomTextField(text: $viewModel.name, title: "Name", placeholder: "Enter Name")
            CustomTextField(text: $viewModel.email, title: "Email", placeholder: "Enter Email")
            CustomTextField(text: $viewModel.password, title: "Password", placeholder: "Enter Password", isSecuredTextEntry: true)
            CustomTextField(text: $viewModel.confirmPassword, title: "Confirm Password", placeholder: "Enter Confirm Password", isSecuredTextEntry: true)
        }
    }
    
    /// Login Button
    private var loginButton: some View {
        
        NavigationLink(isActive: $viewModel.isSignUp) {
            HomeView(viewModel: HomeViewModel())
                .navigationBarHidden(true)
        } label: {
            ButtonView(title: "SIGN UP") {
                viewModel.validateForm()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
