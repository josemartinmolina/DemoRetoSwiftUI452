//
//  HomeScreen.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 25/09/26.
//

import SwiftUI


struct HomeScreen: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    var body: some View {
        NavigationStack{
            TabView{
                Tab{
                    IncidenciasListView()
                        
                    
                }label:{
                    Label("Incidencias", systemImage:"house.and.flag")
                }
                Tab{
                    NavigationStack{
                        Text("Página estadisticas")
                        
                    }
                }label:{
                    Label("Estadisticas", systemImage:"list.dash.header.rectangle")
                }
                Tab{
                    ManejoFoto()
                }label:{
                    Label("Foto", systemImage:"camera")
                }
                Tab{
                    NavigationStack{
                        
                            Text("Página perfil del usuario")
                            //ProfileView()
                            Button("Salir de la sesión"){
                                TokenStorage.delete(identifier: "accessToken")
                                TokenStorage.delete(identifier: "refreshToken")
                                isLoggedIn = false
                            }
                        
                        
                    }
                }label:{
                    Label("Perfil", systemImage:"person.crop.circle")
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
