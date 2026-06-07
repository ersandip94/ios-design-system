# API Design Philosophy

The call site is the product. These rules keep every `CWS*` component obvious and hard to misuse.

## Slots for containers, constrained params for leaves

The central decision is *how much freedom to give the caller* — made deliberately, per component.

- **Containers** take a `@ViewBuilder` content slot — they don't know what goes inside.
  ``CWSCard`` is the example: `CWSCard { Text("…") }`.
- **Leaves** take typed parameters, not slots. ``CWSButton`` accepts a `title` and an optional
  `systemImage`, *not* arbitrary content — so you cannot jam a `Stack` into a button and every
  button stays consistent.

> Slots = flexibility; constrained params = consistency. Knowing where to *withhold* flexibility is
> what separates a design system from a widget grab-bag.

## State hoisting

Components are stateless. State is hoisted to the caller via `@Binding` (the SwiftUI-native
equivalent of passing `value` + `onValueChange`). No component owns a source of truth, which makes
each one trivial to preview and snapshot in any state.

## Style protocols first

Themable controls are built as a `ButtonStyle` / `ToggleStyle` (e.g. ``CWSButtonStyle``), then
wrapped in a convenience `View` (``CWSButton``). Callers can therefore style a raw `Button` too —
the convenience view is sugar, not a wall.

## Enums over boolean explosion

Variants are enums (``CWSButtonVariant``), never overlapping booleans. `isPrimary && isDanger` is
an unrepresentable, meaningless state; `variant: .danger` is exactly one choice, checked by the
compiler.

## Sensible defaults

The simplest meaningful call is one line: `CWSButton("Continue") { }`. Defaults encode the house
style (`variant: .primary`, `size: .medium`), and every component ships an accessibility label.
