//
//  PokemonDetailViewModel.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let pokemonId: Int
    private var cancellables = Set<AnyCancellable>()
    private let apiService = PokemonApiService()
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        fetchPokemonDetail()
    }
    
    func fetchPokemonDetail() {
        isLoading = true
        
        apiService.fetchPokemonDetail(pokemonId: pokemonId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { pokemonDetail in
                self.pokemonDetail = pokemonDetail
            })
            .store(in: &cancellables)
    }
}
