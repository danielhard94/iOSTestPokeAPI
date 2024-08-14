//
//  AuthViewModel.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.user = Auth.auth().currentUser
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = result?.user
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = result?.user
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

