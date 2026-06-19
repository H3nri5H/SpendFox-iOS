import SwiftData
import SwiftUI

struct VehicleListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Vehicle.displayName) private var vehicles: [Vehicle]
    @State private var showingAddVehicle = false

    var body: some View {
        Group {
            if vehicles.isEmpty {
                EmptyStateView(
                    title: "Keine Fahrzeuge",
                    systemImage: "car",
                    description: "Lege ein Fahrzeug an, um Stammdaten lokal zu verwalten."
                )
            } else {
                List {
                    ForEach(vehicles) { vehicle in
                        HStack(spacing: 12) {
                            Image(systemName: vehicle.fuelType == .electric ? "bolt.car" : "car")
                                .frame(width: 30)
                                .foregroundStyle(.tint)
                                .accessibilityHidden(true)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(vehicle.displayName)
                                    .font(.body.weight(.medium))

                                let details = [vehicle.manufacturer, vehicle.modelName]
                                    .filter { !$0.isEmpty }
                                    .joined(separator: " ")

                                Text(details.isEmpty ? vehicle.fuelType.name : details)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            if !vehicle.licensePlate.isEmpty {
                                Text(vehicle.licensePlate)
                                    .font(.caption.monospaced())
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .accessibilityElement(children: .combine)
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationTitle("Fahrzeuge")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddVehicle = true
                } label: {
                    Label("Fahrzeug hinzufügen", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddVehicle) {
            NavigationStack {
                AddVehicleView()
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(vehicles[index])
        }
        try? modelContext.save()
    }
}
