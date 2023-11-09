//
//  FetchController.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 03/11/2023.
//

import Foundation

class FetchController {
    enum NetworkError: Error {
        case badURL, badResponse, badData, allPokemonsFetched
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    var nextPage: URL?
    private static var results: [TempPokemon]?
    
    func fetchPokemons(
        offset: String,
        limit: String
    ) async throws -> [TempPokemon] {
        var allPokemon: [TempPokemon] = []
        
        guard let baseURL else {
            throw NetworkError.badURL
        }
        
        var fetchComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: true
        )
        
        fetchComponents?.queryItems = [URLQueryItem(name: "offset", value: offset)]
        fetchComponents?.queryItems?.append(contentsOf:[URLQueryItem(name: "limit", value: limit)]) 
        
        guard let fetchURL = fetchComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let pokeDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let pokedex = pokeDictionary["results"] as? [[String: String]]
        else {
            throw NetworkError.badData
        }
        
        if let nextPageURL = pokeDictionary["next"] as? String {
            nextPage = URL(string: nextPageURL)
        }
        
        for pokemon in pokedex {
            if let urlString = pokemon["url"],
               let url = URL(string: urlString) {
                allPokemon.append(try await fetchPokemonDetails(from: url))
                FetchController.results = allPokemon
            }
        }
        
        return allPokemon
    }
    
    private func fetchPokemonDetails(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let tempPokemon = try JSONDecoder().decode(TempPokemon.self, from: data)
        
        print("Fetched \(tempPokemon.id): \(tempPokemon.name)")
        
        return tempPokemon
    }
}
