import SwiftUI

/// Visual style of a ``CWSCard``.
public enum CWSCardVariant: Sendable {
    case elevated
    case outlined
    case filled
}

/// A themed surface container — a *container* component: it takes a `@ViewBuilder` content slot and
/// knows nothing about what goes inside.
///
/// ```swift
/// CWSCard {
///     Text("Reykjavík").font(CWSTypography.titleMedium)
///     Text("Iceland")
/// }
/// ```
public struct CWSCard<Content: View>: View {
    @Environment(\.cwsTheme) private var theme

    private let variant: CWSCardVariant
    private let content: Content

    public init(variant: CWSCardVariant = .elevated, @ViewBuilder content: () -> Content) {
        self.variant = variant
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.sm) {
            content
        }
        .padding(CWSSpacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(theme.colorScheme.onSurface)
        .background(backgroundColor, in: RoundedRectangle(cornerRadius: CWSRadius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: CWSRadius.lg)
                .strokeBorder(theme.colorScheme.outline, lineWidth: variant == .outlined ? 1 : 0)
        }
        .cwsShadow(variant == .elevated ? .level2 : .level0)
    }

    private var backgroundColor: Color {
        switch variant {
        case .elevated, .outlined: theme.colorScheme.surface
        case .filled: theme.colorScheme.primaryContainer
        }
    }
}

#Preview("Light") {
    CWSCardPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSCardPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSCardPreview: View {
    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSCard {
                Text("Elevated").font(CWSTypography.titleMedium)
                Text("A raised surface with a shadow.")
            }
            CWSCard(variant: .outlined) {
                Text("Outlined").font(CWSTypography.titleMedium)
            }
            CWSCard(variant: .filled) {
                Text("Filled").font(CWSTypography.titleMedium)
            }
        }
        .padding()
    }
}
