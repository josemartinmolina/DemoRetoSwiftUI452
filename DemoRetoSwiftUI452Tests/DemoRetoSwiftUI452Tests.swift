//
//  DemoRetoSwiftUI452Tests.swift
//  DemoRetoSwiftUI452Tests
//
//  Created by José Molina on 03/10/26.
//

import Testing
@testable import DemoRetoSwiftUI452
@MainActor
struct DemoRetoSwiftUI452Tests {

    @Test func testEstadoInicialIncidencias() {
        let vm = IncidenciasViewModel()
        #expect(vm.incidencias.isEmpty)
        #expect(vm.errorMessage == nil)
        #expect(vm.isLoading == false)
    }

    @Test func testCargaDeIncidencias() async throws {
            let vm = IncidenciasViewModel()
            await vm.fetch()
            #expect(vm.incidencias.count > 0)
            #expect(vm.errorMessage == nil)
        }
    
    @Test func testUsuarioValido() {
        let usuario = RegistroUsuario.Usuario(
            correo: "usuario@correo.com",
            contraseña: "12345"
        )
        
        let errores = usuario.validaDatos()
        
        #expect(errores.isEmpty)
    }
    
    @Test func testCorreoInvalidoFallaEsperada() {
        withKnownIssue("Esta falla es intencional: un correo inválido no debería pasar la validación.") {
            #expect("correo-invalido".esCorreoValido)
        }
    }
    
    @Test func testPasswordCortaFallaEsperada() {
        withKnownIssue("Esta falla es intencional: una contraseña corta no debería pasar la validación.") {
            #expect("1234".esLongitudValida)
        }
    }

}
