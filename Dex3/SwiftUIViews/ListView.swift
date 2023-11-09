//
//  ListView.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 08/11/2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.pokedex, id:\.self) { pokemon in
                    NavigationLink(value: pokemon) {
                        Cell(pokemon: pokemon)
                    }
                    .listRowSeparator(.hidden)
                }
                
                if viewModel.hasMorePagesToFetch() {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Image(systemName: "hourglass")
                            .foregroundStyle(.yellow)
                            .symbolEffect(.variableColor.reversing)
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()
                    }
                    .frame(height: 50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            Task {
                                await viewModel.getPokemons(offset: viewModel.pokedex.count)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("PineTree Pokedex")
            .navigationDestination(for: TempPokemon.self, destination: { pokemon in
                PokemonDetail(pokemon: pokemon)
            })
        }
    }
}

#Preview {
    ListView(viewModel: ViewModel(controller: FetchController()))
        .preferredColorScheme(.dark)
}
