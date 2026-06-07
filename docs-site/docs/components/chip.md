# Chip

A compact, interactive chip — filter (toggleable), input (removable), or suggestion.

```swift
@State private var selected = true

CWSChip("Beaches", isSelected: selected) { selected.toggle() }
```

## Variants

```swift
CWSChip("Mountains") { }                                   // filter (default)
CWSChip("Cities", systemImage: "building.2") { }           // with a leading symbol
CWSChip("kotlin", variant: .input, onClose: { remove() }) { }   // removable
CWSChip("Add filter", variant: .suggestion, systemImage: "plus") { }
```

A selected chip fills with the `primaryContainer` role; unselected shows an `outline` border. The
input variant renders a close affordance when `onClose` is provided.

!!! note "Accessibility"
    Labeled by its text, with the `.isSelected` trait reflecting state. The leading symbol is
    decorative; the close control is labeled "Remove *label*".
