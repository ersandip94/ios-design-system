# Slider

A themed slider with an optional label. State is hoisted via a `Double` binding.

```swift
@State private var volume = 0.6

CWSSlider(value: $volume, label: "Volume")
```

## Range & step

```swift
CWSSlider(value: $brightness, in: 0...100, step: 5, label: "Brightness")
```

The track tints with the `primary` role. When `step` is `0` (default) the slider is continuous.

!!! note "Accessibility"
    Built on SwiftUI's `Slider`, so it's announced as an adjustable control; the label is combined
    into the element.
