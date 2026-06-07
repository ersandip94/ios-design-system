import SwiftUI

/// Visual emphasis of a CWS button.
public enum CWSButtonVariant: Sendable {
    case primary
    case secondary
    case ghost
    case danger
}

/// Size of a CWS button.
public enum CWSButtonSize: Sendable {
    case small
    case medium
    case large
}

/// The themed button style. Apply to any SwiftUI `Button` via
/// `.buttonStyle(CWSButtonStyle(variant:size:))`, or use the ``CWSButton`` convenience view.
public struct CWSButtonStyle: ButtonStyle {
    @Environment(\.cwsTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public var variant: CWSButtonVariant
    public var size: CWSButtonSize

    public init(variant: CWSButtonVariant = .primary, size: CWSButtonSize = .medium) {
        self.variant = variant
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        let palette = palette(for: theme.colorScheme)
        configuration.label
            .font(CWSTypography.labelLarge)
            .foregroundStyle(palette.foreground)
            .tint(palette.foreground)
            .padding(.horizontal, horizontalPadding)
            .frame(minHeight: minHeight)
            .background(palette.background, in: RoundedRectangle(cornerRadius: CWSRadius.md))
            .overlay {
                RoundedRectangle(cornerRadius: CWSRadius.md)
                    .strokeBorder(palette.border, lineWidth: palette.borderWidth)
            }
            .opacity(opacity(pressed: configuration.isPressed))
            .animation(CWSMotion.short, value: configuration.isPressed)
            .cwsMinimumTapTarget()
    }

    private func opacity(pressed: Bool) -> Double {
        guard isEnabled else { return 0.38 }
        return pressed ? 0.85 : 1
    }

    private var minHeight: CGFloat {
        switch size {
        case .small: 32
        case .medium: 44
        case .large: 52
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: CWSSpacing.sm + CWSSpacing.xs
        case .medium: CWSSpacing.md
        case .large: CWSSpacing.lg
        }
    }

    private struct Palette {
        var background: Color
        var foreground: Color
        var border: Color
        var borderWidth: CGFloat
    }

    private func palette(for scheme: CWSColorScheme) -> Palette {
        switch variant {
        case .primary:
            Palette(background: scheme.primary, foreground: scheme.onPrimary, border: .clear, borderWidth: 0)
        case .secondary:
            Palette(background: .clear, foreground: scheme.primary, border: scheme.outline, borderWidth: 1)
        case .ghost:
            Palette(background: .clear, foreground: scheme.primary, border: .clear, borderWidth: 0)
        case .danger:
            Palette(background: scheme.error, foreground: scheme.onError, border: .clear, borderWidth: 0)
        }
    }
}
