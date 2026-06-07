# Versioning & Migration Strategy

The package is a **contract**. The moment another team depends on it, every public symbol becomes a
promise. This page is that contract: how versions are numbered, what counts as breaking, how APIs
are retired, and how consumers migrate.

!!! info "Distribution"
    Released as a Swift Package via **git tags** (SwiftPM resolves tags). Version is the single
    source of truth in the tag; the published surface is everything `public` in `CWSDesignSystem`
    and `CWSDesignSystemFoundation`.

---

## 1. Semantic Versioning

We follow [SemVer 2.0.0](https://semver.org) — `MAJOR.MINOR.PATCH`:

| Bump | When | Example |
|---|---|---|
| **MAJOR** | A breaking change to the public API | remove `CWSButtonVariant.ghost`, rename a parameter |
| **MINOR** | Backward-compatible additions | add a component, an enum case, an optional param *with a default* |
| **PATCH** | Backward-compatible fixes | correct a disabled-state color, fix a layout bug |

For a UI library "breaking" is broader than most libraries — it includes **visual/behavioral**
compatibility too:

- Removing or renaming a public symbol → **MAJOR**
- Changing a default that alters existing layouts (e.g. default `size` `.medium` → `.large`) → **MAJOR**
- Adding an optional parameter *with a default* → **MINOR** (existing call sites unaffected)
- Reordering parameters → **MAJOR**

---

## 2. Guarding the API surface

SwiftPM ships a built-in checker. CI runs it against the last release tag, so any accidental break
shows up as a failing check:

```bash
swift package diagnose-api-breaking-changes "$(git describe --tags --abbrev=0)"
```

This is the Swift equivalent of a binary-compatibility validator — it diffs the public ABI and
flags removed/changed symbols.

---

## 3. Deprecation policy

We **never** delete a public symbol cold. The lifecycle uses Swift's `@available`, so Xcode offers
an automatic fix-it:

```
v1.x  active  ──▶  v1.(x+n)  @available(deprecated, renamed:)  ──▶  v2.0  removed
                          (at least one MINOR release of overlap)
```

```swift
@available(*, deprecated, renamed: "CWSButton(_:variant:action:)")
public init(_ title: String, isDanger: Bool, action: @escaping () -> Void) {
    self.init(title, variant: isDanger ? .danger : .primary, action: action)
}
```

- **`deprecated`** first — code compiles with a warning + *Replace with* fix-it.
- **`unavailable`** in the release before removal — forces the migration, symbol still present.
- **Removed** only at the next MAJOR.

---

## 4. Changelog

Every release ships a [Keep a Changelog](https://keepachangelog.com)-style `CHANGELOG.md`, grouped
so consumers can scan for what affects them:

```markdown
## [1.1.0] — 2026-07-01
### Added
- `CWSButtonVariant.link` for inline text actions.
### Deprecated
- `CWSButton(isDanger:)` — use `variant: .danger`. Removed in 2.0.
### Fixed
- `CWSToggle` now honors Reduce Motion.
```

---

## 5. Migration example (a MAJOR upgrade)

=== "Before (1.x)"
    ```swift
    CWSButton("Delete account", isDanger: true) { delete() }
    ```

=== "After (2.0)"
    ```swift
    CWSButton("Delete account", variant: .danger) { delete() }
    ```

**How consumers migrate safely:**

1. Upgrade to the last `1.x` — deprecation warnings light up every affected call site.
2. Apply Xcode's *Replace with* fix-it (powered by `renamed:`) across the project.
3. Build clean (no warnings) → bump to `2.0.0`.

The overlap is the point: a consumer is **never forced to rewrite and upgrade in the same step**.
