# Sheet

A themed bottom sheet — a **view modifier** wrapping SwiftUI's `.sheet` with resizable detents, a
themed background, and a drag indicator.

```swift
@State private var showingFilters = false

screen
    .cwsSheet(isPresented: $showingFilters) {
        VStack(alignment: .leading, spacing: CWSSpacing.md) {
            Text("Filters").font(CWSTypography.titleLarge)
            CWSToggle("Open now", isOn: $openNow)
            CWSButton("Apply") { showingFilters = false }
        }
    }
```

## Detents

```swift
screen.cwsSheet(isPresented: $showing, detents: [.medium, .large]) { … }
```

!!! note "Theme re-injection"
    Sheets present in a **separate environment**, so `cwsSheet` re-injects the active `CWSTheme` for
    you — your sheet content stays on-brand without any extra `.cwsTheme(…)` call.
