# Toggle

A themed labeled switch. State is hoisted via an `isOn` binding.

```swift
@State private var notifications = true

CWSToggle("Notifications", isOn: $notifications)
```

The track fills with the `primary` role when on and `outline` when off; the knob animates with the
`CWSMotion.short` token (and respects **Reduce Motion**).

## Styling a raw Toggle

`CWSToggle` wraps `CWSToggleStyle`, which you can apply to any `Toggle`:

```swift
Toggle("Wi-Fi", isOn: $wifi).toggleStyle(CWSToggleStyle())
```

!!! note "Accessibility"
    Built on SwiftUI's `Toggle`, so it's announced as a switch with its on/off value; the whole row
    is tappable.
