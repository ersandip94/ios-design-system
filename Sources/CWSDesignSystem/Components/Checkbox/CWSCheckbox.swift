import SwiftUI

/// The themed checkbox style for toggles. Apply via `.toggleStyle(CWSCheckboxStyle())` or use the
/// ``CWSCheckbox`` convenience view.
public struct CWSCheckboxStyle: ToggleStyle {
    @Environment(\.cwsTheme) private var theme

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: CWSSpacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: CWSRadius.xs)
                    .fill(configuration.isOn ? theme.colorScheme.primary : .clear)
                RoundedRectangle(cornerRadius: CWSRadius.xs)
                    .strokeBorder(
                        configuration.isOn ? theme.colorScheme.primary : theme.colorScheme.outline,
                        lineWidth: 2
                    )
                if configuration.isOn {
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(theme.colorScheme.onPrimary)
                        .accessibilityHidden(true)
                }
            }
            .frame(width: 22, height: 22)

            configuration.label
                .font(CWSTypography.bodyLarge)
                .foregroundStyle(theme.colorScheme.onSurface)
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .onTapGesture { configuration.isOn.toggle() }
        .frame(minHeight: CWSAccessibility.minTapTarget)
    }
}

/// A themed checkbox with a trailing label. State is hoisted via the `isOn` binding.
///
/// ```swift
/// CWSCheckbox("I agree to the terms", isOn: $accepted)
/// ```
public struct CWSCheckbox: View {
    @Binding private var isOn: Bool
    private let label: String

    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        self._isOn = isOn
    }

    public var body: some View {
        Toggle(label, isOn: $isOn)
            .toggleStyle(CWSCheckboxStyle())
    }
}

#Preview("Light") {
    CWSCheckboxPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSCheckboxPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSCheckboxPreview: View {
    @State private var terms = true
    @State private var newsletter = false

    var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.md) {
            CWSCheckbox("I agree to the terms", isOn: $terms)
            CWSCheckbox("Subscribe to the newsletter", isOn: $newsletter)
        }
        .padding()
    }
}
