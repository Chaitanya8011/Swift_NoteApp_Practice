//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI

@main
struct NoteAppApp: App {
    let persisteneceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,persisteneceController.container.viewContext)
        }
    }
}
