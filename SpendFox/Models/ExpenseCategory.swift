import Foundation

enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    case housing
    case groceries
    case mobility
    case leisure
    case health
    case other

    var id: String { rawValue }

    var name: String {
        switch self {
        case .housing: "Wohnen"
        case .groceries: "Lebensmittel"
        case .mobility: "Mobilität"
        case .leisure: "Freizeit"
        case .health: "Gesundheit"
        case .other: "Sonstiges"
        }
    }

    var systemImage: String {
        switch self {
        case .housing: "house"
        case .groceries: "cart"
        case .mobility: "car"
        case .leisure: "gamecontroller"
        case .health: "heart"
        case .other: "ellipsis.circle"
        }
    }
}
