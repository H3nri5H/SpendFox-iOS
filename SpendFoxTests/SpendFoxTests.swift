import XCTest
@testable import SpendFox

final class SpendFoxTests: XCTestCase {
    func testMoneyParserUnderstandsGermanDecimalSeparator() {
        XCTAssertEqual(
            Money.cents(from: "12,34", locale: Locale(identifier: "de_DE")),
            1_234
        )
    }

    func testCurrentMonthTotalExcludesOlderExpenses() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let referenceDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 19))!
        let current = Expense(
            amountCents: 1_500,
            occurredAt: calendar.date(from: DateComponents(year: 2026, month: 6, day: 2))!,
            merchant: "Current",
            category: .groceries
        )
        let older = Expense(
            amountCents: 9_900,
            occurredAt: calendar.date(from: DateComponents(year: 2026, month: 5, day: 31))!,
            merchant: "Old",
            category: .other
        )

        XCTAssertEqual(
            SpendingCalculator.currentMonthTotal(
                expenses: [current, older],
                referenceDate: referenceDate,
                calendar: calendar
            ),
            1_500
        )
    }

    func testEveryExpenseCategoryHasANameAndSymbol() {
        for category in ExpenseCategory.allCases {
            XCTAssertFalse(category.name.isEmpty)
            XCTAssertFalse(category.systemImage.isEmpty)
        }
    }
}
