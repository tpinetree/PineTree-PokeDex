//
//  ContentView.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 03/11/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.status {
        case .fetching where viewModel.pokedex.count == 0:
            ProgressView()
        case .failed(let error) where viewModel.pokedex.count == 0:
            ErrorView(error: error.localizedDescription)
        case .success, .fetching, .failed(_):
            ListView(viewModel: viewModel)
        case .notStarted:
            Text("Not fetching yet")
        }
    }
}

#Preview {
    return ContentView(viewModel: ViewModel(controller: FetchController()))
}

