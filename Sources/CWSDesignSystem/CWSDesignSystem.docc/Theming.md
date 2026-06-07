# Theming

How colors, dark mode, and custom brands flow through the system.

## The environment, not the call site

The active theme lives in the SwiftUI environment as a `CWSTheme`, injected with `.cwsTheme(_:)`
and read by components via `@Environment(\.cwsTheme)` (backed by the `@Entry` macro). You set it
once, high in the tree:

```swift
RootView()
    .cwsTheme(.dark)
```

Components never read raw colors — they resolve semantic roles from a `CWSColorScheme`
(`primary`, `onSurface`, `outline`, …). That indirection is what makes dark mode and re-skinning
free.

## Light, dark, and custom brand

```swift
.cwsTheme(.light)            // default
.cwsTheme(.dark)             // dark scheme
.cwsTheme(.brand(.purple))   // light scheme re-skinned with a custom primary
```

`CWSTheme.brand(_:)` overrides only the `primary` role; every other semantic role is preserved, so
a single line restyles every component.

## Tokens

Beyond color, the system exposes global token namespaces used directly in layout:

- `CWSSpacing` — `none … xxxl`
- `CWSRadius` — `xs … full`
- `CWSTypography` — Dynamic Type-backed font tokens (scale with the user's text size)
- `CWSShadow` — elevation levels, applied with `.cwsShadow(_:)`
- `CWSMotion` — standard animation curves
