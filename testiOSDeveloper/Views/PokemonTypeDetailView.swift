//
//  PokemonTypeDetailView.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import SwiftUI

struct PokemonTypeDetailView: View {
    let typeId: Int
    @StateObject private var viewModel: PokemonTypeDetailViewModel
    
    init(typeId: Int) {
        self.typeId = typeId
        _viewModel = StateObject(wrappedValue: PokemonTypeDetailViewModel(typeId: typeId))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                List(viewModel.pokemonEntries, id: \.pokemon.url) { entry in
                    HStack {
                        NavigationLink(destination: PokemonDetailView(pokemonId: entry.pokemon.url)) {
                            Text(entry.pokemon.name.capitalized)
                        }
                    }
                }
            }
        }
        .navigationTitle("Pokémon by Type")
        .onAppear {
            viewModel.fetchPokemonTypeDetail()
        }
    }
}
