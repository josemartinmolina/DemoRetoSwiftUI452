//
//  ControladorRegistroUsuario.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import Foundation
struct ControladorRegistroUsuario {
    let httpClient:HTTPClient
    func registerUser(email:String, password:String) async throws ->  DTORegistroUsuarioResponse{
        let response = try await httpClient.RegistroUsuario(email: email, password: password)
        return response
    }
    func loginUser(email:String, password:String) async throws ->  Bool{
        let loginResponse = try await httpClient.Login(email: email, password: password)
        TokenStorage.set(identifier: "accessToken", value: loginResponse.accessToken)
        TokenStorage.set(identifier: "refreshToken", value: loginResponse.refreshToken)
        return loginResponse.accessToken != nil

    }
}
