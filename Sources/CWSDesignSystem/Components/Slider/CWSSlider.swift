import SwiftUI

/// A themed slider with an optional label. State is hoisted via the `value` binding.
///
/// ```swift
/// CWSSlider(value: $volume, in: 0...100, label: "Volume")
/// ```
public struct CWSSlider: View {
    @Environment(\.cwsTheme) private var theme

    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private let step: Double.Stride
    private let label: String?

    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double.Stride = 0,
        label: String? = nil
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.label = label
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.xs) {
            if let label {
                Text(label)
                    .font(CWSTypography.labelLarge)
                    .foregroundStyle(theme.colorScheme.onSurface)
            }
            slider
                .tint(theme.colorScheme.primary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(label ?? "Slider"))
    }

    @ViewBuilder private var slider: some View {
        if step > 0 {
            Slider(value: $value, in: range, step: step)
        } else {
            Slider(value: $value, in: range)
        }
    }
}

#Preview("Light") {
    CWSSliderPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSSliderPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSSliderPreview: View {
    @State private var volume = 0.6
    @State private var brightness = 40.0

    var body: some View {
        VStack(spacing: CWSSpacing.lg) {
            CWSSlider(value: $volume, label: "Volume")
            CWSSlider(value: $brightness, in: 0...100, step: 5, label: "Brightness")
        }
        .padding()
    }
}
