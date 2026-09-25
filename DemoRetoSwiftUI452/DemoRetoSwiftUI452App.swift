//
//  DemoRetoSwiftUI452App.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 11/09/26.
//

import SwiftUI

@main
struct DemoRetoSwiftUI452App: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //RegistroUsuario()
            if isLoggedIn{
                HomeScreen()
            }else{
                NavigationStack { Login()}
            }
           
        }
    }
}


