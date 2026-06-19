import SwiftData
import SwiftUI

struct ProductListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Product.purchasedAt, order: .reverse) private var products: [Product]
    @State private var searchText = ""
    @State private var showingAddProduct = false

    private var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return products }

        return products.filter {
            $0.name.localizedStandardContains(searchText)
                || $0.manufacturer.localizedStandardContains(searchText)
                || $0.category.name.localizedStandardContains(searchText)
        }
    }

    var body: some View {
        Group {
            if products.isEmpty {
                EmptyStateView(
                    title: "Keine Produkte",
                    systemImage: "shippingbox",
                    description: "Speichere langlebige Anschaffungen und ihren Kaufpreis."
                )
            } else {
                List {
                    ForEach(filteredProducts) { product in
                        HStack(spacing: 12) {
                            Image(systemName: product.category.systemImage)
                                .frame(width: 30)
                                .foregroundStyle(.tint)
                                .accessibilityHidden(true)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(product.name)
                                    .font(.body.weight(.medium))
                                Text(product.manufacturer.isEmpty ? product.category.name : product.manufacturer)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text(Money.formatted(cents: product.purchasePriceCents))
                                .font(.body.weight(.semibold))
                        }
                        .accessibilityElement(children: .combine)
                    }
                    .onDelete(perform: delete)
                }
                .searchable(text: $searchText, prompt: "Produkte durchsuchen")
            }
        }
        .navigationTitle("Produkte")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddProduct = true
                } label: {
                    Label("Produkt hinzufügen", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddProduct) {
            NavigationStack {
                AddProductView()
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredProducts[index])
        }
        try? modelContext.save()
    }
}
