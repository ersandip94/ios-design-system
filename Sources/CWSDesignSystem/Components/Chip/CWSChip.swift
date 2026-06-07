import SwiftUI

/// Behavior/appearance of a ``CWSChip``.
public enum CWSChipVariant: Sendable {
    case filter
    case input
    case suggestion
}

/// A compact, interactive chip — filter (toggleable), input (removable), or suggestion.
///
/// ```swift
/// CWSChip("Beaches", isSelected: selected) { selected.toggle() }
/// CWSChip("kotlin", variant: .input, onClose: { remove() }) {}
/// ```
public struct CWSChip: View {
    @Environment(\.cwsTheme) private var theme

    private let label: String
    private let variant: CWSChipVariant
    private let isSelected: Bool
    private let systemImage: String?
    private let onClose: (() -> Void)?
    private let action: () -> Void

    public init(
        _ label: String,
        variant: CWSChipVariant = .filter,
        isSelected: Bool = false,
        systemImage: String? = nil,
        onClose: (() -> Void)? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.variant = variant
        self.isSelected = isSelected
        self.systemImage = systemImage
        self.onClose = onClose
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: CWSSpacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .accessibilityHidden(true)
                }
                Text(label)
                    .font(CWSTypography.labelLarge)
                if variant == .input, let onClose {
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture(perform: onClose)
                        .accessibilityLabel(Text("Remove \(label)"))
                }
            }
            .padding(.horizontal, CWSSpacing.md)
            .frame(minHeight: 36)
            .foregroundStyle(foreground)
            .background(background, in: Capsule())
            .overlay {
                Capsule().strokeBorder(theme.colorScheme.outline, lineWidth: isSelected ? 0 : 1)
            }
        }
        .buttonStyle(.plain)
        .cwsMinimumTapTarget()
        .accessibilityLabel(Text(label))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var background: Color {
        isSelected ? theme.colorScheme.primaryContainer : .clear
    }

    private var foreground: Color {
        isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface
    }
}

#Preview("Light") {
    CWSChipPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSChipPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSChipPreview: View {
    @State private var selected = true

    var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.md) {
            HStack {
                CWSChip("Beaches", isSelected: selected) { selected.toggle() }
                CWSChip("Mountains") {}
                CWSChip("Cities", systemImage: "building.2") {}
            }
            CWSChip("kotlin", variant: .input, onClose: {}, action: {})
            CWSChip("Add filter", variant: .suggestion, systemImage: "plus") {}
        }
        .padding()
    }
}
