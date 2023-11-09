//
//  ErrorView.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 08/11/2023.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "nosign")
                .symbolEffect(.variableColor.reversing)
                .padding()
            
            Text(error)
                .padding(.horizontal, 20)
                
            Spacer()
        }
    }
}

#Preview {
    ErrorView(error: "Error")
}
