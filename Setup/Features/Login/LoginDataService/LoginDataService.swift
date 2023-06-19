//
//  LoginDataService.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import Foundation
import Combine

class LoginDataService {
    
    @Published var response: Result<Login, Error>?
    var cancellables: AnyCancellable?
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func login() {
        
        let body: [String:Any] = ["email": email,
                                  "password": password]
        
        cancellables = NetworkingManager.downloadDataWith(endPoint: .login, httpMethod: .post, body: body)
            .decode(type: Login.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.response = .failure(error)
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.response = .success(response)
                self.cancellables?.cancel()
            })
    }
}
