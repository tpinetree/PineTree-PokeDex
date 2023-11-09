//
//  Stats.swift
//  Dex3
//
//  Created by Tiago Pinheiro on 04/11/2023.
//

import SwiftUI
import Charts

struct StatsView: View {
    var pokemon: TempPokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(
                x: .value("value", stat.value),
                y: .value("Stat", stat.label)
            )
            .annotation(position: .trailing) {
                Text("\(stat.value)")
                    .padding(.top, -5)
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .frame(height: 250)
        .padding([.leading, .bottom, .trailing])
        .foregroundStyle(Color(pokemon.types.first?.capitalized ?? "Grass"))
        .chartXScale(domain: 0...pokemon.highestStat.value + 5)
    }
}

#Preview {
    StatsView(pokemon: TempPokemon.makeTempPokemon())
        .preferredColorScheme(.dark)
}
