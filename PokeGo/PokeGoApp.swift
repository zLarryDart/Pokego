//
//  PokeGoApp.swift
//  PokeGo
//
//  Created by Armando Larios on 04/02/24.
//

import SwiftUI

@main
struct PokeGoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
