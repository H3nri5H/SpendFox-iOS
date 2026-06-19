import SwiftData
import SwiftUI

struct AddVehicleView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var displayName = ""
    @State private var manufacturer = ""
    @State private var modelName = ""
    @State private var licensePlate = ""
    @State private var fuelType: VehicleFuelType = .petrol

    var body: some View {
        Form {
            Section("Fahrzeug") {
                TextField("Anzeigename", text: $displayName)
                TextField("Hersteller", text: $manufacturer)
                TextField("Modell", text: $modelName)
                TextField("Kennzeichen", text: $licensePlate)
                    .textInputAutocapitalization(.characters)
            }

            Section("Antrieb") {
                Picker("Kraftstoff", selection: $fuelType) {
                    ForEach(VehicleFuelType.allCases) { fuelType in
                        Text(fuelType.name)
                            .tag(fuelType)
                    }
                }
            }
        }
        .navigationTitle("Neues Fahrzeug")
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
                .disabled(displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }

    private func save() {
        modelContext.insert(
            Vehicle(
                displayName: displayName.trimmingCharacters(in: .whitespacesAndNewlines),
                manufacturer: manufacturer.trimmingCharacters(in: .whitespacesAndNewlines),
                modelName: modelName.trimmingCharacters(in: .whitespacesAndNewlines),
                licensePlate: licensePlate.trimmingCharacters(in: .whitespacesAndNewlines),
                fuelType: fuelType
            )
        )
        try? modelContext.save()
        dismiss()
    }
}
