//
//  PruebasUnitariasXCTest.swift
//  DemoRetoSwiftUI452Tests
//
//  Created by José Molina on 03/10/26.
//

import XCTest
@testable import DemoRetoSwiftUI452

final class PruebasUnitariasXCTest: XCTestCase {

    @MainActor
    func testEstadoInicialIncidencias() {
        let vm = IncidenciasViewModel()
        
        XCTAssertTrue(vm.incidencias.isEmpty)
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }
    
    @MainActor
    func testCargaDeIncidencias() async throws {
        let vm = IncidenciasViewModel()
        
        await vm.fetch()
        
        XCTAssertGreaterThan(vm.incidencias.count, 0)
        XCTAssertNil(vm.errorMessage)
    }
    
    func testUsuarioValido() {
        let usuario = RegistroUsuario.Usuario(
            correo: "usuario@correo.com",
            contraseña: "12345"
        )
        
        let errores = usuario.validaDatos()
        
        XCTAssertTrue(errores.isEmpty)
    }
    
    func testCorreoInvalidoFallaEsperada() {
        XCTExpectFailure("Esta falla es intencional: un correo inválido no debería pasar la validación.") {
            XCTAssertTrue("correo-invalido".esCorreoValido)
        }
    }
    
    func testPasswordCortaFallaEsperada() {
        XCTExpectFailure("Esta falla es intencional: una contraseña corta no debería pasar la validación.") {
            XCTAssertTrue("1234".esLongitudValida)
        }
    }

}
