//
//  WordlyPremiumApp.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 03/03/25.
//

import SwiftUI
import SwiftData

@main
struct WordlyPremiumApp: App {
    let dataService = DataService()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.background.ignoresSafeArea()
                ContentView()
                    .environment(\.dataService, dataService)
            }
        }
    }
}
