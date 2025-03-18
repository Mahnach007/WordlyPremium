//
//  WordlyPremiumApp.swift
//  WordlyPremium
//

import SwiftUI
import SwiftData

@main
struct WordlyPremiumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Folder.self, Pack.self, Flashcard.self])
        }
    }
}

// Simple placeholder ContentView in case it's not defined elsewhere
struct ContentView: View {
    var body: some View {
        FoldersView()
    }
} 