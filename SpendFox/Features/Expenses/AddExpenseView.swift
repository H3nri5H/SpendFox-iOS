import SwiftData
import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var amount = ""
    @State private var merchant = ""
    @State private var date = Date.now
    @State private var category: ExpenseCategory = .groceries
    @State private var note = ""

    private var amountCents: Int? {
        Money.cents(from: amount)
    }

    var body: some View {
        Form {
            Section("Buchung") {
                TextField("Betrag", text: $amount)
                    .keyboardType(.decimalPad)

                TextField("Händler oder Empfänger", text: $merchant)

                DatePicker(
                    "Datum",
                    selection: $date,
                    displayedComponents: .date
                )
            }

            Section("Kategorie") {
                Picker("Kategorie", selection: $category) {
                    ForEach(ExpenseCategory.allCases) { category in
                        Label(category.name, systemImage: category.systemImage)
                            .tag(category)
                    }
                }
            }

            Section("Notiz") {
                TextField("Optional", text: $note, axis: .vertical)
                    .lineLimit(3 ... 6)
            }
        }
        .navigationTitle("Neue Ausgabe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Abbrechen") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Sichern") {
                    save()
                }
                .disabled(amountCents == nil)
            }
        }
    }

    private func save() {
        guard let amountCents else { return }

        let expense = Expense(
            amountCents: amountCents,
            occurredAt: date,
            merchant: merchant.trimmingCharacters(in: .whitespacesAndNewlines),
            note: note.trimmingCharacters(in: .whitespacesAndNewlines),
            category: category
        )
        modelContext.insert(expense)
        try? modelContext.save()
        dismiss()
    }
}
