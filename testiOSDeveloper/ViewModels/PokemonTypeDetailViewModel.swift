//
//  PokemonTypeDetailViewModel.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation
import Combine

class PokemonTypeDetailViewModel: ObservableObject {
    @Published var pokemonEntries: [PokemonTypeDetail.PokemonEntry] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let typeId: Int
    private var cancellables = Set<AnyCancellable>()
    private let apiService = PokemonApiService()
    
    init(typeId: Int) {
        self.typeId = typeId
        fetchPokemonTypeDetail()
    }
    
    func fetchPokemonTypeDetail() {
        isLoading = true
        let urlString = "type/\(typeId)/"
        apiService.fetchPokemonTypeDetail(urlString: urlString) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.pokemonEntries = detail.pokemon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
