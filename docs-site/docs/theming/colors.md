# Colors

The system separates a **primitive palette** from **semantic roles**. Components only ever read
semantic roles, which is what makes theming and dark mode free.

## Semantic roles — `CWSColorScheme`

Components resolve roles, never raw colors:

| Role | Used for |
|---|---|
| `primary` / `onPrimary` | primary actions (filled buttons), and content on them |
| `primaryContainer` / `onPrimaryContainer` | tonal surfaces (filled cards, selected chips) |
| `background` / `onBackground` | the screen background |
| `surface` / `onSurface` | cards, sheets, bars, and text on them |
| `surfaceVariant` | subtle fills |
| `outline` | borders and dividers |
| `error` / `onError` | destructive/error states |

Read them from the active theme:

```swift
@Environment(\.cwsTheme) private var theme
// …
.foregroundStyle(theme.colorScheme.onSurface)
.background(theme.colorScheme.surface)
```

## Primitive palette — `CWSColors`

The raw brand and neutral ramps that schemes are built from (prefer the roles above in app code):

```swift
CWSColors.brand900   // #0C3A25  ← brand anchor (matches the Compose system)
CWSColors.brand500
CWSColors.neutral50 … CWSColors.neutral900
CWSColors.error · .warning · .success · .info
```

## Built-in schemes

```swift
CWSColorScheme.light                       // default
CWSColorScheme.dark                        // dark
CWSColorScheme.light(primaryBrand: .pink)  // re-skinned
```

Next: [Dark mode](dark-mode.md) · [Custom brand](custom-brand.md).
