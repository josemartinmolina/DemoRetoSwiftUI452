//
//  RegistroUsuario.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 11/09/26.
//

import SwiftUI

struct RegistroUsuario: View {
    @State var usuario = Usuario()
    @State var erroresFormulario:[String] = []
    var body: some View {
        VStack{
            Text("Registro de Usuario")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Form{
                TextField("Correo", text: $usuario.correo)
                SecureField("Contraseña",text:$usuario.contraseña)
                Button("Registrar"){
                    erroresFormulario = usuario.validaDatos()
                    
                }
            }
            if erroresFormulario.count > 0{
                ResumenErrores(errores: erroresFormulario)
            }
            
        }
    }
}

extension RegistroUsuario{
    struct Usuario{
        var correo:String = ""
        var contraseña:String = ""
        
        func validaDatos()->[String]{
            var errores:[String] = []
            
            if correo.estaVacia{
                errores.append("Debes ingresar un correo")
            }
            if contraseña.estaVacia{
                errores.append("Debes ingresar una contraseña")
            }
            if !contraseña.esLongitudValida{
                errores.append("La contraseña debe tener al menos 5 caracteres")
            }
            if !correo.esCorreoValido{
                errores.append("Debes ingresar un correo valido")
            }
            return errores
        }
    }
}

#Preview {
    RegistroUsuario()
}
