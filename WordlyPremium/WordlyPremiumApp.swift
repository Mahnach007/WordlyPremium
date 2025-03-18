//
//  WordlyPremiumApp.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftData
import SwiftUI

@main
struct WordlyPremiumApp: App {
    @StateObject private var dataService = DataService()

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.background.ignoresSafeArea()
                ContentView()
                    .environmentObject(dataService)
            }
        }
    }
}
