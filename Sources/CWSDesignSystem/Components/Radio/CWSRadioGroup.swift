import SwiftUI

/// A themed single-select radio group over a list of options. Selection is hoisted via `selection`.
///
/// ```swift
/// CWSRadioGroup(selection: $size, options: ["S", "M", "L"])
/// // or with custom labels:
/// CWSRadioGroup(selection: $plan, options: Plan.allCases) { $0.displayName }
/// ```
public struct CWSRadioGroup<Value: Hashable>: View {
    @Environment(\.cwsTheme) private var theme

    @Binding private var selection: Value
    private let options: [Value]
    private let label: (Value) -> String

    public init(
        selection: Binding<Value>,
        options: [Value],
        label: @escaping (Value) -> String
    ) {
        self._selection = selection
        self.options = options
        self.label = label
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.sm) {
            ForEach(options, id: \.self) { option in
                row(for: option)
            }
        }
    }

    private func row(for option: Value) -> some View {
        let isSelected = option == selection
        return HStack(spacing: CWSSpacing.sm) {
            ZStack {
                Circle()
                    .strokeBorder(
                        isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                        lineWidth: 2
                    )
                    .frame(width: 22, height: 22)
                if isSelected {
                    Circle()
                        .fill(theme.colorScheme.primary)
                        .frame(width: 12, height: 12)
                }
            }
            Text(label(option))
                .font(CWSTypography.bodyLarge)
                .foregroundStyle(theme.colorScheme.onSurface)
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .onTapGesture { selection = option }
        .frame(minHeight: CWSAccessibility.minTapTarget)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(label(option)))
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
}

extension CWSRadioGroup where Value == String {
    /// Convenience for `String` options, using each value as its own label.
    public init(selection: Binding<String>, options: [String]) {
        self.init(selection: selection, options: options, label: { $0 })
    }
}

#Preview("Light") {
    CWSRadioGroupPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSRadioGroupPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSRadioGroupPreview: View {
    @State private var size = "Medium"

    var body: some View {
        CWSRadioGroup(selection: $size, options: ["Small", "Medium", "Large"])
            .padding()
    }
}
