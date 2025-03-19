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
    
    /// Load folders initially
    init() {
        refreshFolders()
    }

    /// Folders
    func createFolder(withName name: String) {
        dataService.createFolder(name: name)
        refreshFolders()  // Refresh after creating
    }

    func fetchAllFolders() -> [FolderEntity] {
        dataService.fetchAllFolders()
    }
    
    /// Update the published property
    func refreshFolders() {
        folders = fetchAllFolders()
    }
}
