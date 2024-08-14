//
//  SignInView.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingSignUp = false
    let randomInt = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Text("PokeApi")
                       .font(.largeTitle)  // Estilo grande para el título
                       .fontWeight(.bold)  // Negrita
            
            Text("Por: Juan Daniel Peralta Chacon")
                .font(.subheadline)  // Estilo grande para el título
                       .padding()
            if let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(randomInt).png") {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            TextField("Correo", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Contraseña", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Iniciar sesión") {
                    viewModel.signIn(email: email, password: password)
                }
                .padding()
                
                Button("¿No tienes una cuenta?") {
                    showingSignUp = true
                }
                .padding()
                .sheet(isPresented: $showingSignUp) {
                    SignUpView()
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

