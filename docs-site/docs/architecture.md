# Architecture

The design system is a **Swift Package** with two layered library targets. The split enforces a
one-way dependency: tokens and theming never depend on component composition.

## Layered architecture

```mermaid
flowchart TB
    PRES["🧩 &nbsp; <b>Components</b> &nbsp; · &nbsp; CWSDesignSystem<br/><br/><small>CWSButton · CWSTextField · CWSCard · CWSChip · CWSToggle<br/>CWSDialog · CWSSheet · CWSTopBar · CWSTabBar · …</small>"]
    FOUND["🎨 &nbsp; <b>Foundation</b> &nbsp; · &nbsp; CWSDesignSystemFoundation<br/><br/><small>Tokens (Colors · Spacing · Typography · Radius · Shadow · Motion)<br/>Theme (CWSTheme · CWSColorScheme · @Entry) · Accessibility</small>"]

    PRES -- "depends on · @_exported import" --> FOUND

    classDef components fill:#6FC3AD,stroke:#4FA98E,color:#FFFFFF;
    classDef foundation fill:#F98E7E,stroke:#E07565,color:#FFFFFF;
    class PRES components;
    class FOUND foundation;
```

- **`CWSDesignSystemFoundation`** — design tokens, the `CWSTheme` / `CWSColorScheme` model, the
  `@Entry`-backed environment, and accessibility helpers. **No component code, no dependencies.**
- **`CWSDesignSystem`** — the components. Depends on Foundation and **re-exports** it
  (`@_exported import`), so consumers need only `import CWSDesignSystem`.

!!! info "The dependency rule"
    Foundation must never import Components. Tokens/theme stay free of UI composition so they can be
    reasoned about and tested in isolation — and so a component can never sneak a circular reference
    into the token layer.

## Theming flows through the environment

There's no global singleton. The active theme is injected once and read by every component via the
SwiftUI environment:

```mermaid
flowchart LR
    inject["RootView()<br/>.cwsTheme(.dark)"] -->|"@Entry cwsTheme"| env[(Environment)]
    env -->|"@Environment(\\.cwsTheme)"| c1["CWSButton"]
    env --> c2["CWSCard"]
    env --> c3["CWSTextField"]
```

This is why dark mode is automatic and a custom brand is one line — components resolve **semantic
roles** from the injected `CWSColorScheme`, never hardcoded colors. See [Theming](theming/colors.md).

## Repository layout

```
ios-design-system/
├─ Package.swift                      # 2 library targets + tests
├─ Sources/
│  ├─ CWSDesignSystemFoundation/      # Tokens · Theme (@Entry) · Accessibility
│  └─ CWSDesignSystem/                # Components + DocC catalog
├─ Tests/
│  ├─ CWSDesignSystemTests/           # Swift Testing
│  └─ CWSSnapshotTests/               # snapshot goldens (iOS sim)
├─ Gallery/                           # showcase app (XcodeGen)
└─ docs-site/                         # this MkDocs site
```
