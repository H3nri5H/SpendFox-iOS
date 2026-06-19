import SwiftData

enum AppModelContainer {
    static func make(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([
            Expense.self,
            Product.self,
            Vehicle.self
        ])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("SwiftData container could not be created: \(error)")
        }
    }
}
