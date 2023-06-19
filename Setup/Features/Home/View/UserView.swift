//
//  UserView.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import SwiftUI

struct UserView: View {
    
    var name: String?
    var location: String?
    
    var body: some View {
        HStack {
            Image("noData")
                .resizable()
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.theme.secondaryText)
                )
                .padding(8)
            VStack(alignment: .leading, spacing: 20) {
                Text(name ?? "")
                    .font(.font.bold(14))
                    .foregroundColor(Color.theme.secondaryText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                Text(location ?? "")
                    .font(.font.bold(12))
                    .foregroundColor(Color.theme.secondaryText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
            Spacer()
        }
        .listRowSeparator(.hidden)
        
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.background)
                .shadow(radius: 2)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
