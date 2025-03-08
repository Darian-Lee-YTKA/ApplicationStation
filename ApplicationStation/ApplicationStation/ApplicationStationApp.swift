//
//  ApplicationStationApp.swift
//  ApplicationStation
//
//  Created by Darian Lee on 3/8/25.
//

import SwiftUI
import FirebaseCore
@main

struct ApplicationStationApp: App {
    init() { // <-- Add an init
            FirebaseApp.configure() // <-- Configure Firebase app
        }
    @StateObject private var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
