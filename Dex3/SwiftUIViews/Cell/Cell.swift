//
//  GridView.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 05/11/2023.
//

import SwiftUI

struct Cell: View {
    var pokemon: TempPokemon
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: pokemon.sprite) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: UIScreen.main.bounds.width / 6.5)
            .shadow(color: .white, radius: 5)
            
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            
            Spacer()
        }
        .padding([.leading, .trailing, .top, .bottom], 20)
        .background(.gray.opacity(0.2))
        .cornerRadius(50)
    }
}

#Preview {
    Cell(pokemon: TempPokemon.makeTempPokemon())
        .preferredColorScheme(.dark)
}
