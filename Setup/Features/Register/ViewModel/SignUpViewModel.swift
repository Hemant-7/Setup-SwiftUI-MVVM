//
//  SignUpViewModel.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isValidName = false
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    @Published var isValidConfirmPassword = false
    @Published var isValidationSuccessful = false
    @Published var isPasswordAndConfirmPasswordMatches = false
    @Published var isSignUp = false
    
    @Published var isLoading: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var alertType: ToastModifier._Type = .plain
    
    private var dataService = SignupDataService(name: "", email: "", password: "")
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $name
            .map { name in
                fullnamePredicate.evaluate(with: name)
            }
            .assign(to: \.isValidName, on: self)
            .store(in: &cancellables)
        
        $email
            .map { email in
                emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellables)
        
        $password
            .map { password in
                passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellables)
        
        $confirmPassword
            .map { confirmPassword in
                passwordPredicate.evaluate(with: confirmPassword)
            }
            .assign(to: \.isValidConfirmPassword, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                password == confirmPassword
            }
            .assign(to: \.isPasswordAndConfirmPasswordMatches, on: self)
            .store(in: &cancellables)
        
    }
    
    func validateForm() {
        if !isValidName {
            showAlert(message: "Please enter a valid name.")
        } else if !isValidEmail {
            showAlert(message: "Please enter a valid email.")
        } else if !isValidPassword {
            showAlert(message: "Your password must contain minimum eight characters, at least one upper case letter, one lowercase letter, one special character and one number.")
        } else if !isValidConfirmPassword{
            showAlert(message: "Your confirm password must contain minimum eight characters, at least one upper case letter, one lowercase letter, one special character and one number.")
        } else if !isPasswordAndConfirmPasswordMatches {
            showAlert(message: "Your password and confirm password are not matching.")
        } else {
            signup()
        }
    }
    
    private func showAlert(message: String, type: ToastModifier._Type = .error) {
        alertMessage = message
        alertType = type
        showAlert.toggle()
    }
    
    private func signup() {
        isLoading = true
        dataService = SignupDataService(name: name, email: email, password: password)
        dataService.$response
            .sink { [weak self] receivedValue in
                self?.isLoading = false
                guard let self = self else { return }
                if let result = receivedValue {
                    switch result {
                    case .success(let data):
                        if data.code == 0 {
                            self.showAlert(message: data.message ?? "", type: .success)
                            self.isSignUp = true
                        } else {
                            self.showAlert(message: data.message ?? "", type: .error)
                            self.isSignUp = false
                        }
                    case .failure(let error):
                        self.showAlert(message: error.localizedDescription, type: .plain)
                    }
                }
            }
            .store(in: &cancellables)
        dataService.signup()
    }
}
