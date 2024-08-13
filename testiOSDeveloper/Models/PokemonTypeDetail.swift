//
//  PokemonTypeDetail.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation

struct PokemonTypeDetail: Decodable {
    let pokemon: [PokemonEntry]
    
    struct PokemonEntry: Decodable {
        let pokemon: Pokemon
        
        struct Pokemon: Decodable {
            let name: String
            let url: String
        }
        let slot: Int
    }
}

