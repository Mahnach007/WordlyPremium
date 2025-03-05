//
//  NavigationViewModel.swift
//  WordlyPremium
//
//  Created by Diego Arroyo on 04/03/25.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var destination: AnyView? = nil  // Almacena AnyView para poder almacenar cualquier vista

    func navigateTo<Destination: View>(_ view: Destination) {
        destination = AnyView(view) // Convierte la vista destino a AnyView
    }
}
