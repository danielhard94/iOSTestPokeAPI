//
//  SignUpView.swift
//  testiOSDeveloper
//
//  Created by Daniel Peralta on 13/08/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    let randomInt = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Text("Registrate")
                       .font(.largeTitle)  // Estilo grande para el título
                       .fontWeight(.bold)
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
                Button("Registrarse") {
                    viewModel.signUp(email: email, password: password)
                }
                .padding()
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

