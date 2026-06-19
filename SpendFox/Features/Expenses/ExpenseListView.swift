import SwiftData
import SwiftUI

struct ExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.occurredAt, order: .reverse) private var expenses: [Expense]
    @State private var searchText = ""
    @State private var showingAddExpense = false

    private var filteredExpenses: [Expense] {
        guard !searchText.isEmpty else { return expenses }

        return expenses.filter {
            $0.merchant.localizedStandardContains(searchText)
                || $0.note.localizedStandardContains(searchText)
                || $0.category.name.localizedStandardContains(searchText)
        }
    }

    var body: some View {
        Group {
            if expenses.isEmpty {
                EmptyStateView(
                    title: "Keine Ausgaben",
                    systemImage: "list.bullet.rectangle",
                    description: "Erfasse deine erste Ausgabe über die Hinzufügen-Taste."
                )
            } else {
                List {
                    ForEach(filteredExpenses) { expense in
                        ExpenseRow(expense: expense)
                    }
                    .onDelete(perform: delete)
                }
                .searchable(text: $searchText, prompt: "Ausgaben durchsuchen")
            }
        }
        .navigationTitle("Ausgaben")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddExpense = true
                } label: {
                    Label("Ausgabe hinzufügen", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            NavigationStack {
                AddExpenseView()
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredExpenses[index])
        }
        try? modelContext.save()
    }
}

private struct ExpenseRow: View {
    let expense: Expense

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: expense.category.systemImage)
                .frame(width: 30, height: 30)
                .foregroundStyle(.tint)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 3) {
                Text(expense.merchant.isEmpty ? expense.category.name : expense.merchant)
                    .font(.body.weight(.medium))
                    .lineLimit(1)

                Text("\(expense.category.name) · \(expense.occurredAt.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Text(Money.formatted(cents: expense.amountCents))
                .font(.body.weight(.semibold))
        }
        .accessibilityElement(children: .combine)
    }
}
