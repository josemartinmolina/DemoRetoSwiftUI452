//
//  VariablesAmbiente.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var authController = ControladorRegistroUsuario(httpClient: HTTPClient())
}
