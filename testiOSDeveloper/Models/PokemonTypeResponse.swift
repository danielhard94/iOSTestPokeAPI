//
//  PokemonTypeResponse.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation


struct PokemonTypeResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonType]
}
