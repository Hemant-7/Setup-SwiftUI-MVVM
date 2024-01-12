//
//  SignUpDataService.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import Foundation
import Combine

class SignupDataService {
    
    @Published var response: Result<Signup, Error>?
    var cancellables: AnyCancellable?
    
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signup() {
        
        let body: [String:Any] = ["name": name,
                                  "email": email,
                                  "password": password
        ]
        
        cancellables = NetworkingManager.shared.downloadDataWith(endPoint: .signup, httpMethod: .post, body: body)
            .decode(type: Signup.self, decoder: JSONDecoder())
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
