//
//  PokemonDetailView.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//
import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonId: String) {
        
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemonId: URLHelpers.extractPokemonId(from: pokemonId) ?? 0))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if let pokemonDetail = viewModel.pokemonDetail {
                VStack {
                    Text(pokemonDetail.name.capitalized)
                        .font(.title)
                    
                    if let imageUrl = URL(string: pokemonDetail.sprites.other.home.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/0.png") {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    List(pokemonDetail.abilities, id: \.ability.url) { abilityEntry in
                        VStack(alignment: .leading) {
                            Text(abilityEntry.ability.name.capitalized)
                                .font(.headline)
                            Text("Slot: \(abilityEntry.slot)")
                                .font(.subheadline)
                            Text("Hidden: \(abilityEntry.isHidden ? "Yes" : "No")")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}
