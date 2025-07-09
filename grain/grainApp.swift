//
//  grainApp.swift
//  grain
//
//  Created by Yussuf Sassi on 09.07.25.
//

import SwiftUI

@main
struct grainApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
