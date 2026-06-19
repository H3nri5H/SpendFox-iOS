import SwiftData
import SwiftUI

@main
struct SpendFoxApp: App {
    private let modelContainer: ModelContainer = AppModelContainer.make()

    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(modelContainer)
    }
}
