# Button

A themed button — a *leaf* component: a label with an optional leading SF Symbol and a loading
state. No free-form content slot, so every button stays consistent.

```swift
CWSButton("Continue", systemImage: "arrow.right") { submit() }
```

## Variants

```swift
CWSButton("Primary")   { }                          // filled, high-emphasis
CWSButton("Secondary", variant: .secondary) { }     // outlined
CWSButton("Ghost",     variant: .ghost) { }         // text-only
CWSButton("Delete",    variant: .danger) { }        // destructive
```

## Sizes & states

```swift
CWSButton("Small", size: .small) { }
CWSButton("Large", size: .large) { }
CWSButton("Saving", isLoading: true) { }     // shows a ProgressView, auto-disabled
CWSButton("Disabled") { }.disabled(true)
```

## Styling a raw Button

`CWSButton` wraps `CWSButtonStyle`; you can apply it to any `Button`:

```swift
Button("Save") { }.buttonStyle(CWSButtonStyle(variant: .secondary, size: .large))
```

!!! note "Accessibility"
    Ships an `.accessibilityLabel`, enforces the 44pt tap target, and dims to 0.38 opacity when
    disabled. The leading symbol is decorative (`accessibilityHidden`).
