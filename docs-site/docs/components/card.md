# Card

A themed surface container — a *container* component with a `@ViewBuilder` content slot. It owns the
chrome (padding, shape, elevation); you supply the contents.

```swift
CWSCard {
    Text("Reykjavík").font(CWSTypography.titleMedium)
    Text("Iceland")
}
```

## Variants

```swift
CWSCard(variant: .elevated) { … }   // raised surface with a shadow (default)
CWSCard(variant: .outlined) { … }   // flat surface with a hairline border
CWSCard(variant: .filled)   { … }   // tinted with the primaryContainer role
```

Contents are laid out in a leading-aligned `VStack` with `CWSSpacing.sm` between children and
`CWSSpacing.md` padding. Colors come from the theme (`surface` / `primaryContainer`, `onSurface`,
`outline`) and elevation from the `CWSShadow` tokens.
