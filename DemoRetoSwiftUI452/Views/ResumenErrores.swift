//
//  ResumenErrores.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 11/09/26.
//

import SwiftUI

struct ResumenErrores: View {
    var errores:[String] = []
    var body: some View {
        VStack {
            if errores.count > 0 {
                ForEach(errores, id: \.self) { error in
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            else{
                Text("No hay errores").foregroundColor(.green)
            }
        }
        
    }
}

#Preview {
    
    ResumenErrores()
}
