# Component API Design Philosophy

A design system lives or dies by its **public API**. Components are written once but *called*
thousands of times, so the call site is the real product. This page documents the rules every
`CWS*` component follows — and why.

!!! abstract "The one principle"
    **Optimize for the reader at the call site, not the author of the component.** A slightly harder
    component to *write* is worth it if it makes every *usage* obvious and hard to misuse.

---

## 1. Naming & the `CWS` prefix

Every public type is prefixed `CWS` (`CWSButton`, `CWSTheme`, `CWSColors`). Swift namespaces by
module, but the prefix still earns its keep:

- **No collisions** with SwiftUI's own `Button`, `Toggle`, `Slider` — the intent is unambiguous at
  the call site, and you never shadow the framework types.
- **Discoverability** — typing `CWS` surfaces the whole system in autocomplete.

---

## 2. Slots for containers, constrained params for leaves

The biggest API decision is *how much freedom to give the caller*. We make it deliberately, per
component.

**Containers take a `@ViewBuilder` content slot** — they don't know what goes inside:

```swift
public struct CWSCard<Content: View>: View {
    public init(variant: CWSCardVariant = .elevated, @ViewBuilder content: () -> Content)
}

CWSCard {
    Text("Reykjavík").font(CWSTypography.titleMedium)
    Text("Iceland")
}
```

**Leaf components take typed parameters, not slots.** `CWSButton` accepts a `title` and an optional
`systemImage` — *not* arbitrary content:

```swift
CWSButton("Continue", systemImage: "arrow.right") { submit() }
```

!!! danger "Why withhold the slot?"
    If `CWSButton` took a free-form `@ViewBuilder`, every team would build a different-looking
    button. Constraining the API keeps every button consistent. **Slots = flexibility; constrained
    params = consistency.** Knowing where to withhold flexibility is what makes it a *system*.

---

## 3. State hoisting with `@Binding`

Every interactive component is **stateless** — it renders the state it's given and reports changes
upward. State is hoisted to the caller via `@Binding`:

```swift
public struct CWSTextField: View {
    public init(text: Binding<String>, label: String? = nil, /* … */)
}
```

The caller owns `text`; the field just renders it. No component holds a hidden `@State` source of
truth that fights your view model — which is what makes each one trivial to preview and snapshot in
any state.

---

## 4. Style protocols first

Themable controls are built as a SwiftUI **style** (`ButtonStyle`, `ToggleStyle`), then wrapped in
a convenience `View`:

```swift
public struct CWSButtonStyle: ButtonStyle { /* reads @Environment(\.cwsTheme) */ }

// Convenience view…
CWSButton("Save") { }
// …or style a raw Button yourself:
Button("Save") { }.buttonStyle(CWSButtonStyle(variant: .secondary))
```

The convenience view is sugar, not a wall — you can always drop down to the style.

---

## 5. Enums over boolean explosion

Variants are **enums**, never overlapping booleans:

```swift
public enum CWSButtonVariant { case primary, secondary, ghost, danger }
```

!!! danger "The anti-pattern"
    ```swift
    CWSButton("Delete", isPrimary: true, isDanger: true)   // what does this even mean?
    ```
    Booleans allow illegal states. An enum makes variants **mutually exclusive by construction**,
    and `switch` over it stays exhaustive — add a case and the compiler points you at every place to
    update.

---

## 6. Theming through the environment, never hardcoded

Components read the active theme from `@Environment(\.cwsTheme)` (backed by the `@Entry` macro) and
resolve **semantic roles** (`primary`, `onSurface`) — they never hardcode `Color(.systemBackground)`
or hex. That single indirection is what makes dark mode and re-skinning free. See
[Theming](../theming/colors.md).

---

## 7. Sensible defaults

The simplest meaningful call is one line: `CWSButton("Continue") { }`. Defaults encode the house
style (`variant: .primary`, `size: .medium`), and a `nil` default is meaningful too — `text: nil`
on `CWSBadge` switches it from a labeled pill to a notification dot.

---

## Checklist — does a new component's API pass?

- [ ] Prefixed `CWS`, public surface intentional
- [ ] Slot (`@ViewBuilder`) only if it's a *container*; typed params for leaves
- [ ] Stateless — state hoisted via `@Binding`
- [ ] Themable via a `*Style` protocol where it fits
- [ ] Variants as enums — no illegal states representable
- [ ] Reads tokens + `@Environment(\.cwsTheme)`; nothing hardcoded
- [ ] Simplest meaningful call fits on one line
- [ ] Accessibility label/traits + 44pt target (see [Testing](testing.md))
