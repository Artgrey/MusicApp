//
//  Music_AppApp.swift
//  Music App
//
//  Created by iRent No. 3 on 2022-02-21.
//

import SwiftUI

@main
struct Music_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
