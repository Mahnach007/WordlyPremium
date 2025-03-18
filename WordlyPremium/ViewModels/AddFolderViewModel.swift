//
//  AddFolderViewModel.swift
//  WordlyPremium
//
//  Created by Vlad Gotovchykov on 18/03/25.
//

import Foundation



class AddFolderViewModel: ObservableObject {
    
    private var dataService: DataService = DataService()
    @Published var folders: [FolderEntity] = []
    
    init() {
        // Load folders initially
        refreshFolders()
    }
    
    func createFolder(withName name: String) {
        dataService.createFolder(name: name)
        refreshFolders() // Refresh after creating
    }
    
    func fetchAllFolders() -> [FolderEntity] {
        dataService.fetchAllFolders()
    }
    
    func refreshFolders() {
        folders = fetchAllFolders() // Update the published property
    }
}
