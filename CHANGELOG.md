# Changelog

All notable changes to **CWS Design System (SwiftUI)** are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Foundation layer: `CWSColors`, `CWSSpacing`, `CWSTypography`, `CWSRadius`, `CWSShadow`,
  `CWSMotion` tokens.
- Theming via the `@Entry` environment value `cwsTheme` and the `.cwsTheme(_:)` modifier
  (`CWSTheme` / `CWSColorScheme` with `.light`, `.dark`, and custom brand).
- Accessibility helpers: `cwsMinimumTapTarget()` (44pt) and WCAG `cwsContrastRatio(against:)`.
- Components: `CWSButton` (+ `CWSButtonStyle`), `CWSCard`, `CWSTextField`, `CWSBadge` /
  `CWSCountBadge`, `CWSChip`, `CWSToggle` (+ `CWSToggleStyle`), `CWSSlider`, `CWSCheckbox`
  (+ `CWSCheckboxStyle`), `CWSRadioGroup`, the `cwsDialog(…)` / `cwsSheet(…)` view modifiers, and
  `CWSTopBar` / `CWSTabBar` (+ `CWSTabItem`).
- Swift Testing unit tests, a snapshot test for `CWSButton`, DocC catalog, gallery app, and a
  custom SwiftLint accessibility rule.
- DocC: Getting Started + Theming + engineering articles, curated Topics, and a warning-free
  **combined** documentation build (Foundation + Components) for in-Xcode API reference.
- **MkDocs Material documentation site** (`docs-site/`) — Home, Get started, API design, Versioning,
  Testing, Architecture, Theming, and 12 component pages — deployed to GitHub Pages via
  `mkdocs gh-deploy`.

[Unreleased]: https://github.com/ersandip94/ios-design-system/commits/main
