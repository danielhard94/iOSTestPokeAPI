//
//  PokemonTypeView.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//
import SwiftUI

struct PokemonTypeView: View {
    @StateObject private var viewModel = PokemonTypeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemonTypes) { type in
                    Text(type.name.capitalized)
                        .onAppear {
                            // Cargar más tipos cuando el usuario llega al último tipo visible
                            if type == viewModel.pokemonTypes.last {
                                viewModel.loadMoreTypes()
                            }
                        }
                }
                
                // Mostrar un indicador de carga cuando se está cargando más datos
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Pokemon Types")
            .onAppear {
                // Cargar tipos de Pokémon al iniciar la vista
                viewModel.fetchPokemonTypes()
            }
            .onChange(of: viewModel.pokemonTypes) { _ in
                // Acciones a realizar cuando la lista de tipos cambie
                // (Aunque esto no es necesario si solo usamos scroll infinito)
            }
        }
    }
}
