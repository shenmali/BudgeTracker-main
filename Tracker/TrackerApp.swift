//
//  TrackerApp.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI
import Firebase

@main
struct TrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
