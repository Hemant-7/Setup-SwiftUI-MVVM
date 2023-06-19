//
//  HomeView.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//
import Foundation
import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
//        ZStack {
//            Color.theme.background
            VStack {
                navigation
                if viewModel.arrayOfUsers.count > 0 {
                    VStack {
                        usersList
                    }
                } else {
                    if viewModel.isLoading {
                        IndicatorView()
                    } else {
                        noData
                    }
                }
            }
//        }
    }
    
    private var navigation: some View {
        HStack {
            Spacer()
            Button {
                UserDefaults.standard.reset()
            } label: {
                Image("logout")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .padding(.trailing)
        }
        .background(Color.theme.background)
    }
    
    private var usersList: some View {
        
        List(0..<viewModel.arrayOfUsers.count, id: \.self) { index in
            let user = viewModel.arrayOfUsers[index]
            UserView(name: user.name, location: user.location)
                .onAppear {
                    viewModel.loadMore(index)
                }
        }
        .listStyle(PlainListStyle())
    }
    
    private var noData: some View {
        NoDataFoundView(title: viewModel.title, message: viewModel.message) {
            viewModel.url = "api/users"
            self.viewModel.users()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
