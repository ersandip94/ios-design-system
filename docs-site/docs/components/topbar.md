# Top bar

A themed top app bar — a title, an optional back action, and a `@ViewBuilder` slot for trailing
actions. A *container* component: it owns the bar chrome, you supply the controls.

```swift
CWSTopBar("Reykjavík", onBack: { dismiss() }) {
    Button {
        favorite()
    } label: {
        Image(systemName: "heart").accessibilityLabel("Favorite")
    }
    .buttonStyle(.plain)
}
```

Without trailing actions or a back button:

```swift
CWSTopBar("Destinations")
```

The bar uses the `surface` / `onSurface` roles with a hairline `outline` divider along the bottom,
and a 56pt minimum height. The back button is labeled "Back" and meets the 44pt target.
