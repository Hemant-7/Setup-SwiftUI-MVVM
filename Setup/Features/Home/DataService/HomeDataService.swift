//
//  HomeDataService.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import Foundation
import Combine

class HomeDataService {
    
    @Published var response: Result<Users, Error>?
    var cancellables: AnyCancellable?
    
    var page: Int = 1
    var url: String = "api/usersq"
    
    func users() {
        
        cancellables = NetworkingManager.downloadDataWith(endPoint: .usersList(page: page, url: url), httpMethod: .get)
            .decode(type: Users.self, decoder: JSONDecoder())
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
