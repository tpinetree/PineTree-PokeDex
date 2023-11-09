//
//  PokemonDetail.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 04/11/2023.
//

import SwiftUI

struct PokemonDetail: View {
    var pokemon: TempPokemon
    @State var showShiny = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                
                AsyncImage(url: showShiny ? pokemon.shinySprite : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .shadow(color: .black, radius: 6)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text("Types")
                .font(.title)
                .padding(.bottom, -5)
            
            HStack {
                if pokemon.types.count > 0 {
                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type.capitalized)
                            .font(.title2)
                            .shadow(color: .white, radius: 5)
                            .padding([.top, .bottom], 7)
                            .padding([.leading, .trailing])
                            .background(Color(type.capitalized))
                            .cornerRadius(20)
                    }
                }
            }
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom, -5)
            
            StatsView(pokemon: pokemon)
        }
        .navigationTitle(pokemon.name.capitalized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    if showShiny {
                        Image(systemName:"wand.and.stars")
                    } else {
                        Image(systemName:"wand.and.stars.inverse")
                            .foregroundStyle(.yellow)
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonDetail(pokemon: TempPokemon.makeTempPokemon())
}
