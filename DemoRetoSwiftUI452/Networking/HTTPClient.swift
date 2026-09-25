//
//  HTTPClient.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import Foundation
struct HTTPClient {
    
    func RegistroUsuario(email:String, password:String) async throws -> DTORegistroUsuarioResponse{
        let requestForm = DTORegistroUsuarioRequest(email:email, password:password)
        let url = URL(string: "http://localhost:3000/auth/register")!
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try JSONEncoder().encode(requestForm)
        httpRequest.httpBody = jsonData
        let (data, _) = try await URLSession.shared.data(for: httpRequest)
        let response = try JSONDecoder().decode(DTORegistroUsuarioResponse.self, from: data)
        return response
    }
    
    func Login(email:String, password:String) async throws -> DTOLoginResponse{
        let loginRequest = DTOLoginRequest(email:email, password:password)
        //let url = URL(string: "http://localhost:3000/auth/login")!
        guard let url = URL(string: "http://localhost:3000/auth/login") else {
            fatalError("Invalid URL" + "http://localhost:3000/auth/login")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        let (data, response) = try await URLSession.shared.data(for:urlRequest)
        let loginResponse = try JSONDecoder().decode(DTOLoginResponse.self, from: data)
        return loginResponse
    }
    
}
