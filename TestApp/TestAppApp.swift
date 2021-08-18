//
//  TestAppApp.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

import SwiftUI

@main
struct TestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
