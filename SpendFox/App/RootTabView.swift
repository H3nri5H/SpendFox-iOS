import SwiftData
import SwiftUI

struct RootTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var hasSeededPrototype = false

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Übersicht", systemImage: "chart.pie.fill")
            }

            NavigationStack {
                ExpenseListView()
            }
            .tabItem {
                Label("Ausgaben", systemImage: "list.bullet.rectangle")
            }

            NavigationStack {
                ProductListView()
            }
            .tabItem {
                Label("Produkte", systemImage: "shippingbox")
            }

            NavigationStack {
                VehicleListView()
            }
            .tabItem {
                Label("Fahrzeuge", systemImage: "car")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Einstellungen", systemImage: "gearshape")
            }
        }
        .task {
            guard !hasSeededPrototype else { return }
            hasSeededPrototype = true
            try? PrototypeDataSeeder.seedIfNeeded(in: modelContext)
        }
    }
}
