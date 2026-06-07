# Testing Strategy

A design system's output is pixels and behavior, so testing layers several types — each catching a
different class of failure.

## Unit tests — Swift Testing

Pure logic, fast, host-runnable: token relationships, theme/brand resolution, and WCAG contrast
math. Written with the Swift Testing framework:

```swift
@Test("Custom brand overrides the primary role")
func brandOverride() {
    #expect(CWSTheme.brand(.purple).colorScheme.primary == .purple)
}
```

## Snapshot (golden) tests

The highest-leverage test for a design system — the only thing that catches "looks wrong." Built
on [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing): each component
is rendered in light and dark and compared to a committed reference image.

```bash
# record goldens (first run / after an intentional visual change)
SNAPSHOT_TESTING_RECORD=all xcodebuild test -scheme CWSDesignSystem \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

Image snapshots use `UIHostingController`, so they run on an **iOS simulator** via `xcodebuild` —
not `swift test`.

## Accessibility, enforced

- **Authoring** — every interactive component ships an `.accessibilityLabel` and meets the 44pt
  tap target via `cwsMinimumTapTarget()`.
- **Static** — a custom SwiftLint rule (the parallel to the Android `CWSMissingContentDescription`
  lint) flags SF Symbol images with no accessibility decision; it runs as a CI step / local
  `swiftlint` command.
- **Visual** — dark-mode goldens catch contrast regressions.

## What runs where

| Suite | Needs simulator | Frequency |
|---|---|---|
| Unit (Swift Testing) | no | every commit |
| SwiftLint (a11y rule) | no | every build |
| Snapshot goldens | yes | every PR |
