import Foundation

enum Money {
    static func formatted(cents: Int, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let amount = NSDecimalNumber(value: cents).dividing(by: 100)
        return formatter.string(from: amount) ?? "\(amount) €"
    }

    static func cents(from input: String, locale: Locale = .current) -> Int? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true

        let fallback = trimmed
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: ".")

        let number: NSNumber
        if let parsed = formatter.number(from: trimmed) {
            number = parsed
        } else if let decimal = Decimal(string: fallback) {
            number = NSDecimalNumber(decimal: decimal)
        } else {
            return nil
        }

        let cents = number.decimalValue * 100
        var rounded = Decimal()
        var mutableCents = cents
        NSDecimalRound(&rounded, &mutableCents, 0, .plain)
        let value = NSDecimalNumber(decimal: rounded).intValue
        return value > 0 ? value : nil
    }
}
