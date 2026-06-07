# Versioning & Migration

The package is a contract. Once a consumer depends on it, every public symbol is a promise.

## Semantic Versioning

Released via git tags consumed by SwiftPM, following [SemVer](https://semver.org):

| Bump | When |
|---|---|
| **MAJOR** | Remove or rename a public symbol; reorder/relabel parameters; change a default that alters existing layouts |
| **MINOR** | Add a component, an optional parameter *with a default*, or a new enum case |
| **PATCH** | Backward-compatible fixes (a color, a crash) |

## Deprecate, don't delete

Public symbols are never removed cold. They get a deprecation cycle of at least one minor release,
using Swift's `@available` so Xcode offers an automatic fix-it:

```swift
@available(*, deprecated, renamed: "CWSButton(_:variant:action:)")
public init(_ title: String, isDanger: Bool, action: @escaping () -> Void) {
    self.init(title, variant: isDanger ? .danger : .primary, action: action)
}
```

`warning` first, then `unavailable`/removed at the next MAJOR.

## Guarding the surface

CI runs SwiftPM's built-in checker against the last release tag, so any accidental break shows up
as a failing check:

```bash
swift package diagnose-api-breaking-changes "$(git describe --tags --abbrev=0)"
```

Pair it with a [Keep a Changelog](https://keepachangelog.com) `CHANGELOG.md`; MAJOR releases ship a
before/after migration section.
