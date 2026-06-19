# SpendFox iOS

SpendFox is a native iPhone application for tracking personal expenses, durable products and vehicles.

## Prototype scope

The first prototype intentionally stays small and uses standard Apple components:

- SwiftUI interface with five native tabs
- local persistence with SwiftData
- dashboard for the current month
- expense list, search and manual entry
- product list and manual entry
- vehicle list and manual entry
- a small, scalable category enum
- local prototype data on first launch
- no cloud account, analytics or external API calls

All prototype records remain in the app's local SwiftData store. No banking or financial data leaves the device.

## Requirements

- macOS with Xcode 15 or newer
- iOS 17 simulator or iPhone
- no third-party dependencies

Open `SpendFox.xcodeproj`, select the **SpendFox** scheme and run the app.

## Architecture

```text
SpendFox/
├── App/            App entry point and tab navigation
├── Models/         SwiftData entities and small domain enums
├── Persistence/    Model container and prototype seeding
├── Features/       Feature-oriented SwiftUI screens
└── Shared/         Formatting and calculation helpers
```

The UI reads and writes through SwiftData's `ModelContext`. Feature code is separated from persistence setup so a synchronization layer can be introduced later without rebuilding the navigation and forms.

## Next milestones

1. Replace demo seeding with onboarding.
2. Add an ING CSV document import.
3. Introduce editable categories and subcategories.
4. Add local export and encrypted backup.
5. Define a sync protocol and implement Supabase as an optional remote backend.
6. Add an optional self-hosted categorization service.

## Design principles

SpendFox uses `TabView`, `NavigationStack`, `List`, `Form`, SF Symbols, Dynamic Type and system colors. Controls keep their platform behavior and accessibility labels instead of imitating a custom design system prematurely.
