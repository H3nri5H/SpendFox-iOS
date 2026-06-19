import Foundation

enum SpendingCalculator {
    static func currentMonthTotal(
        expenses: [Expense],
        referenceDate: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        guard let month = calendar.dateInterval(of: .month, for: referenceDate) else {
            return 0
        }

        return expenses
            .filter { month.contains($0.occurredAt) }
            .reduce(0) { $0 + $1.amountCents }
    }

    static func totalsByCategory(
        expenses: [Expense],
        referenceDate: Date = .now,
        calendar: Calendar = .current
    ) -> [(category: ExpenseCategory, cents: Int)] {
        guard let month = calendar.dateInterval(of: .month, for: referenceDate) else {
            return []
        }

        let grouped = Dictionary(
            grouping: expenses.filter { month.contains($0.occurredAt) },
            by: \.category
        )

        return grouped
            .map { category, entries in
                (category, entries.reduce(0) { $0 + $1.amountCents })
            }
            .sorted { $0.cents > $1.cents }
    }
}
