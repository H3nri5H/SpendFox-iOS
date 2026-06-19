import Foundation
import SwiftData

@Model
final class Vehicle {
    @Attribute(.unique) var id: UUID
    var displayName: String
    var manufacturer: String
    var modelName: String
    var licensePlate: String
    var fuelTypeRawValue: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        displayName: String,
        manufacturer: String = "",
        modelName: String = "",
        licensePlate: String = "",
        fuelType: VehicleFuelType,
        createdAt: Date = .now
    ) {
        self.id = id
        self.displayName = displayName
        self.manufacturer = manufacturer
        self.modelName = modelName
        self.licensePlate = licensePlate
        self.fuelTypeRawValue = fuelType.rawValue
        self.createdAt = createdAt
    }

    var fuelType: VehicleFuelType {
        get { VehicleFuelType(rawValue: fuelTypeRawValue) ?? .other }
        set { fuelTypeRawValue = newValue.rawValue }
    }
}
