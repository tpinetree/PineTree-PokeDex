//
//  ViewModel.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 04/11/2023.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    private let controller: FetchController
    private let limit: Int = 40
    
    @Published private(set) var pokedex: [TempPokemon] = []
    @Published private(set) var status: Status = .notStarted
    
    init(controller: FetchController) {
        self.controller = controller
        Task {
            await getPokemons(offset: 0)
        }
    }
    
    func getPokemons(offset: Int) async {
        status = .fetching
        
        do {
            var tempArray = try await controller.fetchPokemons(
                offset: String(offset),
                limit: String(limit)
            )
            
            tempArray.sort { $0.id < $1.id }
            
            self.pokedex.append(contentsOf: tempArray)
            status = .success
            
            debugPrint("Number of pokemons in pokedex -> \(pokedex.count)")
        } catch {
            status = .failed(error: error)
            debugPrint("Something went wrong...")
        }
    }
    
    func hasMorePagesToFetch() -> Bool {
        controller.nextPage?.absoluteString.isEmpty == false
    }
}
