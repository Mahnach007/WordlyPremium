import SwiftUI

/// Define the DataService environment key
struct DataServiceKey: EnvironmentKey {
    static let defaultValue = DataService()
}

/// Extend EnvironmentValues to include dataService
extension EnvironmentValues {
    var dataService: DataService {
        get { self[DataServiceKey.self] }
        set { self[DataServiceKey.self] = newValue }
    }
}
