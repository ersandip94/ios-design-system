import SwiftUI

/// The themed switch style for toggles. Apply to any `Toggle` via `.toggleStyle(CWSToggleStyle())`,
/// or use the ``CWSToggle`` convenience view.
public struct CWSToggleStyle: ToggleStyle {
    @Environment(\.cwsTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(CWSTypography.bodyLarge)
                .foregroundStyle(theme.colorScheme.onSurface)
            Spacer()
            Capsule()
                .fill(configuration.isOn ? theme.colorScheme.primary : theme.colorScheme.outline)
                .frame(width: 51, height: 31)
                .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                    Circle()
                        .fill(.white)
                        .padding(2)
                        .frame(width: 31, height: 31)
                }
                .animation(reduceMotion ? nil : CWSMotion.short, value: configuration.isOn)
                .accessibilityHidden(true)
        }
        .contentShape(Rectangle())
        .onTapGesture { configuration.isOn.toggle() }
    }
}

/// A themed labeled switch. State is hoisted via the `isOn` binding.
///
/// ```swift
/// CWSToggle("Notifications", isOn: $enabled)
/// ```
public struct CWSToggle: View {
    @Binding private var isOn: Bool
    private let label: String

    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        self._isOn = isOn
    }

    public var body: some View {
        Toggle(label, isOn: $isOn)
            .toggleStyle(CWSToggleStyle())
    }
}

#Preview("Light") {
    CWSTogglePreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSTogglePreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSTogglePreview: View {
    @State private var notifications = true
    @State private var marketing = false

    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSToggle("Notifications", isOn: $notifications)
            CWSToggle("Marketing emails", isOn: $marketing)
        }
        .padding()
    }
}
