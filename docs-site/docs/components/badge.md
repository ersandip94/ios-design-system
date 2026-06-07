# Badge

A status indicator. Renders as a small **dot** when no text is given, or a labeled **pill** when it
is. `CWSCountBadge` adds numeric clamping.

```swift
CWSBadge()                            // red dot
CWSBadge("New", status: .success)     // green pill
CWSCountBadge(count: 128)             // "99+"
```

## Status

```swift
CWSBadge("Neutral",    status: .neutral)
CWSBadge("Info",       status: .info)
CWSBadge("Success",    status: .success)
CWSBadge("Warning",    status: .warning)   // black text for contrast
CWSBadge("Error",      status: .error)
```

## Count badge

```swift
CWSCountBadge(count: 7)               // "7"
CWSCountBadge(count: 128)             // "99+"  (clamps at max, default 99)
CWSCountBadge(count: 0)               // hidden (opacity 0)
```

!!! note "Accessibility"
    A labeled badge is read as its text; a dot announces "New". `CWSCountBadge` announces
    "*n* items".
