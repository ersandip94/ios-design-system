# Custom brand

Re-skin the **entire system** with a single line — no component changes, no overrides.

```swift
RootView()
    .cwsTheme(.brand(Color(red: 0.41, green: 0.20, blue: 0.65)))
```

`CWSTheme.brand(_:)` starts from the light scheme and overrides only the `primary` role; every other
semantic role (surfaces, outlines, error) is preserved. Because components resolve `primary` from
the environment, buttons, selected chips, toggles, sliders, and focus states all pick up the new
brand instantly.

## Build a fully custom scheme

For complete control, construct a `CWSColorScheme` and wrap it in a `CWSTheme`:

```swift
let scheme = CWSColorScheme(
    primary: brand, onPrimary: .white,
    primaryContainer: brand.opacity(0.12), onPrimaryContainer: brand,
    background: .white, onBackground: .black,
    surface: .white, onSurface: .black,
    surfaceVariant: Color(white: 0.95), outline: Color(white: 0.8),
    error: .red, onError: .white
)

RootView().cwsTheme(CWSTheme(colorScheme: scheme))
```

!!! tip "Check contrast"
    Validate brand pairings against WCAG in a test with the built-in helper:
    `brand.cwsContrastRatio(against: .white) >= 4.5`.
