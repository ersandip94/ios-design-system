# Checkbox & Radio

Multi-select with **`CWSCheckbox`** and single-select with **`CWSRadioGroup`**.

## Checkbox

A themed checkbox with a trailing label. State is hoisted via `isOn`.

```swift
@State private var agreed = false

CWSCheckbox("I agree to the terms", isOn: $agreed)
```

`CWSCheckbox` wraps `CWSCheckboxStyle`, applicable to any `Toggle`:

```swift
Toggle("Remember me", isOn: $remember).toggleStyle(CWSCheckboxStyle())
```

## Radio group

A single-select group over any `Hashable` options. Selection is hoisted via `selection`.

```swift
@State private var size = "Medium"

CWSRadioGroup(selection: $size, options: ["Small", "Medium", "Large"])
```

With custom labels for non-`String` values:

```swift
CWSRadioGroup(selection: $plan, options: Plan.allCases) { $0.displayName }
```

!!! note "Accessibility"
    Each option is a combined element with `.isButton` and, when chosen, `.isSelected`. Rows meet the
    44pt tap target; the checkmark/dot is decorative.
