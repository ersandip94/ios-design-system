import SwiftUI

/// A themed top app bar — a title, an optional back action, and a `@ViewBuilder` slot for trailing
/// actions. A *container* component: it owns the bar chrome, you supply the trailing controls.
///
/// ```swift
/// CWSTopBar("Destinations", onBack: { dismiss() }) {
///     Button { } label: { Image(systemName: "slider.horizontal.3").accessibilityLabel("Filters") }
/// }
/// ```
public struct CWSTopBar<Trailing: View>: View {
    @Environment(\.cwsTheme) private var theme

    private let title: String
    private let onBack: (() -> Void)?
    private let trailing: Trailing

    public init(
        _ title: String,
        onBack: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.onBack = onBack
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(spacing: CWSSpacing.sm) {
            if let onBack {
                Button(action: onBack) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 17, weight: .semibold))
                        .accessibilityLabel(Text("Back"))
                }
                .buttonStyle(.plain)
                .frame(minWidth: CWSAccessibility.minTapTarget, minHeight: CWSAccessibility.minTapTarget)
            }

            Text(title)
                .font(CWSTypography.titleMedium)
                .lineLimit(1)

            Spacer(minLength: CWSSpacing.sm)

            trailing
        }
        .foregroundStyle(theme.colorScheme.onSurface)
        .padding(.horizontal, CWSSpacing.md)
        .frame(minHeight: 56)
        .background(theme.colorScheme.surface)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(theme.colorScheme.outline)
                .frame(height: 0.5)
        }
        .accessibilityElement(children: .contain)
    }
}

extension CWSTopBar where Trailing == EmptyView {
    /// A top bar with no trailing actions.
    public init(_ title: String, onBack: (() -> Void)? = nil) {
        self.init(title, onBack: onBack) { EmptyView() }
    }
}

#Preview("Light") {
    CWSTopBarPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSTopBarPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSTopBarPreview: View {
    var body: some View {
        VStack(spacing: CWSSpacing.xl) {
            CWSTopBar("Destinations")
            CWSTopBar("Reykjavík", onBack: {}) {
                Button {} label: {
                    Image(systemName: "heart")
                        .accessibilityLabel(Text("Favorite"))
                }
                .buttonStyle(.plain)
            }
        }
    }
}
