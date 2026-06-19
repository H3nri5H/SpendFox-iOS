import SwiftData
import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    @State private var manufacturer = ""
    @State private var price = ""
    @State private var purchasedAt = Date.now
    @State private var category: ProductCategory = .technology
    @State private var note = ""

    private var priceCents: Int? {
        Money.cents(from: price)
    }

    var body: some View {
        Form {
            Section("Produkt") {
                TextField("Bezeichnung", text: $name)
                TextField("Hersteller", text: $manufacturer)
                TextField("Kaufpreis", text: $price)
                    .keyboardType(.decimalPad)
                DatePicker(
                    "Kaufdatum",
                    selection: $purchasedAt,
                    displayedComponents: .date
                )
            }

            Section("Kategorie") {
                Picker("Kategorie", selection: $category) {
                    ForEach(ProductCategory.allCases) { category in
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
        .navigationTitle("Neues Produkt")
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
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || priceCents == nil)
            }
        }
    }

    private func save() {
        guard let priceCents else { return }

        modelContext.insert(
            Product(
                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                manufacturer: manufacturer.trimmingCharacters(in: .whitespacesAndNewlines),
                purchasePriceCents: priceCents,
                purchasedAt: purchasedAt,
                note: note.trimmingCharacters(in: .whitespacesAndNewlines),
                category: category
            )
        )
        try? modelContext.save()
        dismiss()
    }
}
