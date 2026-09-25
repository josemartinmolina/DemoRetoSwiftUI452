//
//  DTORegistroUsuaro.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import Foundation

// MARK: - DTORegistroUsuarioRequest
class DTORegistroUsuarioRequest: Codable {
    var email, password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

// MARK: - DTORegistroUsuarioResponse
class DTORegistroUsuarioResponse: Codable {
    var id, email: String

    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
}
