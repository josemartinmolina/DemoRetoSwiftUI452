//
//  ExtensionValidar.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 11/09/26.
//

import Foundation

extension String{
    var esLongitudValida: Bool {
        return count >= 5
    }
    var estaVacia: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var esCorreoValido: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return self.range(of: emailRegEx, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
