# CWS Design System (SwiftUI)

A **SwiftUI** design system — design tokens, theming (light / dark / custom brand), and a curated
set of accessible components, all prefixed `CWS`. Built with **Swift 6 / iOS 18** patterns and
distributed as a **Swift Package**.

[Get started →](getting-started.md){ .md-button .md-button--primary }
[Browse components →](components/button.md){ .md-button }

---

## Explore

<div class="grid cards" markdown>

-   :material-puzzle-outline: **[API Design Philosophy](engineering/api-design.md)**

    ---

    Slot APIs, state hoisting with `@Binding`, style protocols, enums over booleans, and bad-vs-good
    API at the call site.

-   :material-tag-multiple-outline: **[Versioning & Migration](engineering/versioning.md)**

    ---

    SemVer for a SwiftUI library, `@available` deprecation, `swift package diagnose-api-breaking-changes`,
    changelogs, and migrations.

-   :material-test-tube: **[Testing Strategy](engineering/testing.md)**

    ---

    Swift Testing unit tests, snapshot goldens, accessibility enforced multiple ways, and a custom
    SwiftLint rule.

-   :material-sitemap-outline: **[Architecture](architecture.md)**

    ---

    The layered SPM package (Foundation → Components), `@Entry` theming, and the dependency rule.

-   :material-palette-outline: **[Theming](theming/colors.md)**

    ---

    Semantic color roles, dark mode, and re-skinning the whole system with a single custom brand
    color.

-   :material-widgets-outline: **[Components](components/button.md)**

    ---

    12+ accessible components — buttons, inputs, cards, chips, toggles, overlays, navigation.

</div>

---

## Hello, component

A single `import CWSDesignSystem` brings in the components and the re-exported tokens/theming. Wrap
your UI in a theme and use any `CWS*` component:

```swift
import CWSDesignSystem

CWSTheme.light // (inject via .cwsTheme(.light) — see Get started)

VStack(spacing: CWSSpacing.md) {
    CWSTextField(text: $email, label: "Email", leadingIcon: "envelope")
    CWSButton("Get started", systemImage: "arrow.right") { /* … */ }
}
.cwsTheme(.light)
```

[Full setup guide →](getting-started.md){ .md-button }

---

## At a glance

<div class="grid cards" markdown>

- :material-language-swift: **Swift 6 / iOS 18** — `@Entry` theming, `@Observable`-ready, strict concurrency
- :material-widgets: **12+ components** — buttons, inputs, cards, chips, overlays, navigation…
- :material-eye-outline: **Compose-style previews** — every component ships `#Preview`s (light + dark)
- :material-human: **Accessible** — 44pt targets, Dynamic Type, labels, a custom SwiftLint check

</div>

---

*Built with Swift + SwiftUI · [codewithsandip.com](https://codewithsandip.com)*
