//
//  HomeViewModel.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var title: String = ""
    @Published var message: String = ""
    
    
    @Published var arrayOfUsers = [UserData]()
    @Published var isUserData: Bool = false
    
    private var dataService = HomeDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var hasMore: Bool = false
    var page: Int = 1
    
    @Published var url: String = ""
    
    init() {
        users()
    }
    
    func loadMore(_ index: Int) {
        if hasMore && index >= arrayOfUsers.count - 1 {
            page += 1
            print("Load More: \(page)")
            users()
        }
    }
    
    func users() {
        dataService.page = page
        dataService.url = url
        dataService.$response
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let result = receivedValue {
                    switch result {
                    case .success(let data):
                        if let userData = data.data {
                            self.isUserData = true
                            self.hasMore = true
                            self.arrayOfUsers += userData
                        } else {
                            self.hasMore = false
                            self.isUserData = false
                            self.title = "Result Not Found"
                            self.message = "No Data available for a moment"
                        }
                    case .failure(let error):
                        self.hasMore = false
                        self.isUserData = false
                        self.title = "Internal Server Error"
                        self.message = error.localizedDescription
                    }
                }
            }
            .store(in: &cancellables)
        dataService.users()
    }
}
