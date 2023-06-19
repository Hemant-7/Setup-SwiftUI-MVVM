//
//  IndicatorView.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct IndicatorView: View {
    var body: some View {
        ZStack {
            CustomIndicator()
//            VStack(alignment: .center, spacing: 10) {
//                ProgressView()
//                    .tint(.white)
//
//                Text("Loading...")
//                    .font(.caption)
//                    .bold()
//                    .foregroundColor(.white)
//            }
//            .frame(width: 75, height: 75)
//            .background(.gray.opacity(0.65))
//            .cornerRadius(15)
        }
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
    }
}
