//
//  Music_App.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-21.
//

import SwiftUI

@main
struct Music_App: App {
    
    let persistenceController = PersistenceController.shared
     
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
