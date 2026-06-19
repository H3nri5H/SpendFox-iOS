import Foundation

enum ProductCategory: String, CaseIterable, Codable, Identifiable {
    case technology
    case household
    case furniture
    case hobby
    case other

    var id: String { rawValue }

    var name: String {
        switch self {
        case .technology: "Technik"
        case .household: "Haushalt"
        case .furniture: "Möbel"
        case .hobby: "Hobby"
        case .other: "Sonstiges"
        }
    }

    var systemImage: String {
        switch self {
        case .technology: "laptopcomputer"
        case .household: "washer"
        case .furniture: "lamp.floor"
        case .hobby: "paintpalette"
        case .other: "shippingbox"
        }
    }
}
