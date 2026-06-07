# ``CWSDesignSystem``

A SwiftUI design system — design tokens, theming (light / dark / custom brand), and accessible
components, all prefixed `CWS`.

## Overview

CWS is distributed as a Swift package. Wrap your UI in a theme, then use any `CWS*` component:

```swift
import CWSDesignSystem

struct ContentView: View {
    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSButton("Get started", systemImage: "arrow.right") { }
            CWSCard {
                Text("Reykjavík").font(CWSTypography.titleMedium)
                Text("Iceland")
            }
        }
        .padding()
        .cwsTheme(.light)   // or .dark, or .brand(.purple)
    }
}
```

Components are stateless and read everything from the active theme in the environment (`CWSTheme`)
— so re-skinning the whole system is a one-liner and dark mode is automatic. The token and theming
types live in the `CWSDesignSystemFoundation` layer (browse it from the documentation root),
re-exported here so a single `import CWSDesignSystem` is all you need.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:Theming>

### Components

- ``CWSButton``
- ``CWSTextField``
- ``CWSCard``
- ``CWSBadge``
- ``CWSCountBadge``
- ``CWSChip``
- ``CWSToggle``
- ``CWSCheckbox``
- ``CWSRadioGroup``
- ``CWSSlider``
- ``CWSTopBar``
- ``CWSTabBar``

### Overlays

- ``CWSDialogVariant``

### Styles & supporting types

- ``CWSButtonStyle``
- ``CWSToggleStyle``
- ``CWSCheckboxStyle``
- ``CWSTabItem``

### Engineering notes

- <doc:APIDesign>
- <doc:Versioning>
- <doc:Testing>
