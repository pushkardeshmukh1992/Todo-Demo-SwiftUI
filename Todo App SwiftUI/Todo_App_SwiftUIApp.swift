//
//  Todo_App_SwiftUIApp.swift
//  Todo App SwiftUI
//
//  Created by Pushkar Deshmukh on 18/08/23.
//

import SwiftUI

@main
struct Todo_App_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
