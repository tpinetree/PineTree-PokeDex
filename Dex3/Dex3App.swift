//
//  Dex3App.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 03/11/2023.
//

import SwiftUI

@main
struct Dex3App: App {
    @StateObject var viewModel = ViewModel(controller: FetchController())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
