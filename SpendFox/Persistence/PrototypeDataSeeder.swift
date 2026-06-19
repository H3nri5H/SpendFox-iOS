import Foundation
import SwiftData

enum PrototypeDataSeeder {
    @MainActor
    static func seedIfNeeded(in context: ModelContext) throws {
        let existingExpenses = try context.fetch(FetchDescriptor<Expense>())
        let existingProducts = try context.fetch(FetchDescriptor<Product>())
        let existingVehicles = try context.fetch(FetchDescriptor<Vehicle>())

        guard existingExpenses.isEmpty, existingProducts.isEmpty, existingVehicles.isEmpty else {
            return
        }

        let calendar = Calendar.current
        let now = Date.now

        context.insert(
            Expense(
                amountCents: 6_420,
                occurredAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                merchant: "Wocheneinkauf",
                category: .groceries
            )
        )
        context.insert(
            Expense(
                amountCents: 4_900,
                occurredAt: calendar.date(byAdding: .day, value: -3, to: now) ?? now,
                merchant: "Monatsticket",
                category: .mobility
            )
        )
        context.insert(
            Expense(
                amountCents: 1_299,
                occurredAt: calendar.date(byAdding: .day, value: -5, to: now) ?? now,
                merchant: "Streaming",
                category: .leisure
            )
        )

        context.insert(
            Product(
                name: "Notebook",
                manufacturer: "Beispiel",
                purchasePriceCents: 129_900,
                purchasedAt: calendar.date(byAdding: .month, value: -8, to: now) ?? now,
                category: .technology
            )
        )

        context.insert(
            Vehicle(
                displayName: "Alltagsauto",
                manufacturer: "Beispiel",
                modelName: "Kompakt",
                licensePlate: "XX SF 2026",
                fuelType: .petrol
            )
        )

        try context.save()
    }
}
