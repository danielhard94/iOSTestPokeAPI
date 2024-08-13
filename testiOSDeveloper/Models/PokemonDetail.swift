//
//  PokemonDetail.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let abilities: [AbilityEntry]  // Agregado para habilidades
    
    struct Sprites: Codable {
        let other: OtherSprites
    }

    struct OtherSprites: Codable {
        let dreamWorld: DreamWorldSprites
        let home: HomeSprites
        
        enum CodingKeys: String, CodingKey {
            case dreamWorld = "dream_world"
            case home
        }
    }

    struct DreamWorldSprites: Codable {
        let frontDefault: String?
        let frontFemale: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
        }
    }

    struct HomeSprites: Codable {
        let frontDefault: String?
        let frontFemale: String?
        let frontShiny: String?
        let frontShinyFemale: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }

    struct AbilityEntry: Codable {
        let ability: Ability
        let isHidden: Bool
        let slot: Int
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
    }

    struct Ability: Codable {
        let name: String
        let url: String
    }
}
