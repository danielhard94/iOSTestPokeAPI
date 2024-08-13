//
//  PokemonType.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation

struct PokemonType: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    // Inicializador personalizado para extraer el ID de la URL
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        let urlString = try container.decode(String.self, forKey: .url)
        if let url = URL(string: urlString) {
            let components = url.pathComponents
            // ID es el último componente en la URL
            if let idString = components.last(where: { $0.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil }) {
                self.id = Int(idString) ?? 0
            } else {
                self.id = 0
            }
        } else {
            self.id = 0
        }
    }
    
    static func == (lhs: PokemonType, rhs: PokemonType) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
