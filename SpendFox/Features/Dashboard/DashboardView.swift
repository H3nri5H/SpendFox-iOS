import SwiftData
import SwiftUI

struct DashboardView: View {
    @Query(sort: \Expense.occurredAt, order: .reverse) private var expenses: [Expense]
    @Query private var products: [Product]
    @Query private var vehicles: [Vehicle]

    private var monthlyTotal: Int {
        SpendingCalculator.currentMonthTotal(expenses: expenses)
    }

    private var categoryTotals: [(category: ExpenseCategory, cents: Int)] {
        SpendingCalculator.totalsByCategory(expenses: expenses)
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ausgaben in diesem Monat")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(Money.formatted(cents: monthlyTotal))
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        .contentTransition(.numericText())

                    Text("\(expenses.count) erfasste Buchungen insgesamt")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
                .accessibilityElement(children: .combine)
            }

            Section("Kategorien") {
                if categoryTotals.isEmpty {
                    Text("Noch keine Ausgaben in diesem Monat")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(categoryTotals, id: \.category.id) { total in
                        HStack(spacing: 12) {
                            Image(systemName: total.category.systemImage)
                                .frame(width: 28)
                                .foregroundStyle(.tint)
                                .accessibilityHidden(true)

                            Text(total.category.name)

                            Spacer()

                            Text(Money.formatted(cents: total.cents))
                                .fontWeight(.semibold)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
            }

            Section("Bestand") {
                LabeledContent("Produkte", value: "\(products.count)")
                LabeledContent("Fahrzeuge", value: "\(vehicles.count)")
            }
        }
        .navigationTitle("SpendFox")
    }
}
