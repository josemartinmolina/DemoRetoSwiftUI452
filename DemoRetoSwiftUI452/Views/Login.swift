//
//  Login.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import SwiftUI

struct Login: View {
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.authController) var controladorRegistro
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    private func login() async {
        do{
            isLoggedIn = try await controladorRegistro.loginUser(email: email, password: password)
            print("Usuario login exitoso \(isLoggedIn)")
            
        }catch {
            print(error.localizedDescription)
        }
        
    }
    var body: some View {
        NavigationStack{
            Form{
                Text("Inicio de sesión")
                    .font(.title)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity)
                Section{
                    TextField("Correo electrónico", text: $email)
                        .keyboardType(.emailAddress)
                    SecureField("Contraseña", text: $password)
                    
                    Button(action: {
                        Task{
                            await login()
                        }
                        
                    }){
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink("Registrarse"){
                        RegistroUsuario()
                    }
                }
                
            }
        }.navigationTitle("Login")
    }
}


#Preview {
    Login()
}
