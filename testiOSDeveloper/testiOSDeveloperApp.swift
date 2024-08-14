//
//  testiOSDeveloperApp.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 12/08/24.
//

import SwiftUI
import Firebase


@main
struct testiOSDeveloper: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil {
                PokemonTypeView()
            } else {
                SignInView()
            }            
        }
    }
}
