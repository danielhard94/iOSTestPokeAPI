//
//  URLHelpers.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation

struct URLHelpers {
    static func extractPokemonId(from url: String) -> Int? {
        let pattern = "/([0-9]+)/?$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let nsString = url as NSString
        let results = regex?.matches(in: url, options: [], range: NSRange(location: 0, length: nsString.length))

        if let match = results?.first, match.numberOfRanges > 1 {
            let idRange = match.range(at: 1)
            if let range = Range(idRange, in: url) {
                let idString = String(url[range])
                return Int(idString)
            }
        }
        
        return nil
    }
}
