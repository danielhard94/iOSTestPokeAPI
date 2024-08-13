//
//  PokemonApiService.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation

class PokemonApiService {
    private let baseUrl = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonTypes(urlString: String = "type/", completion: @escaping (Result<PokemonTypeResponse, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)\(urlString)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PokemonTypeResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
