import Foundation
import SwiftData

@Model
final class Product {
    @Attribute(.unique) var id: UUID
    var name: String
    var manufacturer: String
    var purchasePriceCents: Int
    var purchasedAt: Date
    var note: String
    var categoryRawValue: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        manufacturer: String = "",
        purchasePriceCents: Int,
        purchasedAt: Date,
        note: String = "",
        category: ProductCategory,
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.manufacturer = manufacturer
        self.purchasePriceCents = purchasePriceCents
        self.purchasedAt = purchasedAt
        self.note = note
        self.categoryRawValue = category.rawValue
        self.createdAt = createdAt
    }

    var category: ProductCategory {
        get { ProductCategory(rawValue: categoryRawValue) ?? .other }
        set { categoryRawValue = newValue.rawValue }
    }
}
