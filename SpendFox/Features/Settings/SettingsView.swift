import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var expenses: [Expense]
    @Query private var products: [Product]
    @Query private var vehicles: [Vehicle]
    @State private var showingDeleteConfirmation = false

    var body: some View {
        Form {
            Section("Datenhaltung") {
                Label("Nur auf diesem Gerät", systemImage: "iphone")
                LabeledContent("Ausgaben", value: "\(expenses.count)")
                LabeledContent("Produkte", value: "\(products.count)")
                LabeledContent("Fahrzeuge", value: "\(vehicles.count)")
            }

            Section("Datenschutz") {
                Text(
                    "Der Prototyp nutzt keine Cloud, keine Analyse-Dienste und keine externen KI-Schnittstellen."
                )
                .foregroundStyle(.secondary)
            }

            Section("Roadmap") {
                Label("ING-CSV-Import", systemImage: "doc.text")
                Label("Lokaler Export und Backup", systemImage: "square.and.arrow.up")
                Label("Optionale Supabase-Synchronisierung", systemImage: "arrow.triangle.2.circlepath")
                Label("Selbst gehostete Kategorisierung", systemImage: "server.rack")
            }

            Section {
                Button("Alle lokalen Daten löschen", role: .destructive) {
                    showingDeleteConfirmation = true
                }
            }

            Section("Über SpendFox") {
                LabeledContent("Version", value: "0.1.0")
                Text("Native iOS prototype")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Einstellungen")
        .confirmationDialog(
            "Alle lokalen Daten löschen?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Daten endgültig löschen", role: .destructive) {
                deleteAllData()
            }
        } message: {
            Text("Diese Aktion kann nicht rückgängig gemacht werden.")
        }
    }

    private func deleteAllData() {
        expenses.forEach(modelContext.delete)
        products.forEach(modelContext.delete)
        vehicles.forEach(modelContext.delete)
        try? modelContext.save()
    }
}
