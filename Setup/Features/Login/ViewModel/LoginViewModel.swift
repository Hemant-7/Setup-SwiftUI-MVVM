//
//  LoginViewModel.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    @Published var isValidationSuccessful = false
    @Published var isLogin = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var alertType: ToastModifier._Type = .plain
    
    private var dataService = LoginDataService(email: "", password: "")
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        UserDefaults.standard.reset()
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
        
        Publishers.CombineLatest($isValidEmail, $isValidPassword)
            .map { isValidEmail, isValidPassword in
                isValidEmail && isValidPassword
            }
            .assign(to: \.isValidationSuccessful, on: self)
            .store(in: &cancellables)
    }
    
    private func showAlert(message: String, type: ToastModifier._Type = .error) {
        alertMessage = message
        alertType = type
        showAlert.toggle()
    }
    
    func validateForm() {
        if !isValidEmail {
            showAlert(message: "Please enter a valid email.")
        } else if !isValidPassword {
            showAlert(message: "Your password must contain minimum eight characters, at least one lowercase letter and one number.")
        } else {
            isLoading = true
            login()
        }
    }
    
    private func login() {
        
        dataService = LoginDataService(email: email, password: password)
        dataService.$response
            .sink { [weak self] receivedValue in
                self?.isLoading = false
                guard let self = self else { return }
                
                if let result = receivedValue {
                    
                    switch result {
                        
                    case .success(let data):
                        if data.code == 0 {
                            self.isLogin = true
                            if let token = data.data?.token {
                                UserObject().setValue(value: token, forKey: UserObject.Constants.token)
                            }
                            self.showAlert(message: data.message ?? "", type: .success)
                        } else {
                            self.showAlert(message: data.message ?? "", type: .error)
                        }
                    case .failure(let error):
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
            .store(in: &cancellables)
        dataService.login()
    }
}
