//
//  NoDataFoundView.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import SwiftUI

struct NoDataFoundView: View {
    
    var image: String? = "noData"
    var title: String? = nil
    let message: String
    let callback: (() -> Void)
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack(alignment: .center, spacing: 12) {
                if let image = image {
                    Image(image)
                        .foregroundColor(Color.theme.background)
                }
                if let title = title {
                    Text(title)
                        .font(.font.bold(16))
                        .multilineTextAlignment(.center)
                }
                Text(message)
                    .font(.font.regular(14))
                    .multilineTextAlignment(.center)
                ButtonView(title: "Refresh") {
                    callback()
                }
                .frame(width: 120)
            }
            .padding(24)
        }
    }
}

struct NoDataFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataFoundView(title: "Server Error", message: "No Data Found nsdhjsdhjsdhjdshdhsdhsjhdshjdjhshdshdshjdhjsdhjsdhjsdhjshdshjdshjdhsdhjsjdhsdhshdhshjd") {
            //
        }
    }
}
