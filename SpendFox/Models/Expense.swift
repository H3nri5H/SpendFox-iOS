import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var amountCents: Int
    var occurredAt: Date
    var merchant: String
    var note: String
    var categoryRawValue: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        amountCents: Int,
        occurredAt: Date,
        merchant: String,
        note: String = "",
        category: ExpenseCategory,
        createdAt: Date = .now
    ) {
        self.id = id
        self.amountCents = amountCents
        self.occurredAt = occurredAt
        self.merchant = merchant
        self.note = note
        self.categoryRawValue = category.rawValue
        self.createdAt = createdAt
    }

    var category: ExpenseCategory {
        get { ExpenseCategory(rawValue: categoryRawValue) ?? .other }
        set { categoryRawValue = newValue.rawValue }
    }
}
