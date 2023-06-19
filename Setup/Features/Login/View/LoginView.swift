//
//  LoginView.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    title
                    loginInput
                    loginButton
                    signupButton
                }
                .padding(24)
            }
        }
        .indicator(isShowing: $viewModel.isLoading)
        .toast(isShowing: $viewModel.showAlert, message: viewModel.alertMessage, type: viewModel.alertType)
        
    }
    
    /// Title
    private var title: some View {
        Text("LOGIN")
            .font(.font.bold(40))
            .padding(.vertical, 100)
    }
    
    /// User Login email and
    ///  User Password
    private var loginInput: some View {
        VStack(spacing: 20) {
            CustomTextField(text: $viewModel.email, title: "Email", placeholder: "Enter Email")
            CustomTextField(text: $viewModel.password, title: "Password", placeholder: "Enter Password", isSecuredTextEntry: true)
        }
    }
    
    /// Login Button
    private var loginButton: some View {
        NavigationLink(isActive: $viewModel.isLogin) {
            HomeView(viewModel: HomeViewModel())
                .navigationBarHidden(true)
        } label: {
            ButtonView(title: "LOGIN") {
                viewModel.validateForm()
            }
        }
    }
    
    /// Signup button if user don't have account
    private var signupButton: some View {
        NavigationLink {
            SignUpView(viewModel: SignUpViewModel())
        } label: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .font(.font.medium(16))
                    .foregroundColor(Color.theme.primaryText)
            }
            Text("SIGN UP")
                .font(.font.medium(16))
                .foregroundColor(Color.theme.cyan)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
