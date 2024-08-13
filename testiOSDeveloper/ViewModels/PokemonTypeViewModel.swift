//
//  PokemonTypeViewModel.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation
import Combine

class PokemonTypeViewModel: ObservableObject {
    @Published var pokemonTypes: [PokemonType] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var nextUrl: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = PokemonApiService()
    
    func fetchPokemonTypes(urlString: String = "type/") {
        isLoading = true
        apiService.fetchPokemonTypes(urlString: urlString) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.pokemonTypes.append(contentsOf: response.results)
                    self?.nextUrl = response.next
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadMoreTypes() {
        guard let nextUrl = nextUrl else { return }
        fetchPokemonTypes(urlString: nextUrl)
    }
}
