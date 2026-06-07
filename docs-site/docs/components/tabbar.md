# Tab bar

A themed bottom tab bar driven by a `selection` binding (matched against each item's `id`). Place it
at the bottom of your layout.

```swift
@State private var tab = 0

CWSTabBar(selection: $tab, items: [
    .init(id: 0, title: "Home",    systemImage: "house"),
    .init(id: 1, title: "Explore", systemImage: "map"),
    .init(id: 2, title: "Saved",   systemImage: "bookmark"),
    .init(id: 3, title: "Profile", systemImage: "person"),
])
```

Each item is a `CWSTabItem` (`id`, `title`, `systemImage`). The selected item tints with the
`primary` role; the rest use `outline`. A hairline `outline` divider sits along the top.

!!! note "Accessibility"
    Each tab is labeled by its title with the `.isButton` trait, and `.isSelected` on the active tab.
    Icons are decorative; rows meet the 44pt target.
