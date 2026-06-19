import Foundation

enum VehicleFuelType: String, CaseIterable, Codable, Identifiable {
    case petrol
    case diesel
    case hybrid
    case electric
    case other

    var id: String { rawValue }

    var name: String {
        switch self {
        case .petrol: "Benzin"
        case .diesel: "Diesel"
        case .hybrid: "Hybrid"
        case .electric: "Elektro"
        case .other: "Sonstiges"
        }
    }
}
