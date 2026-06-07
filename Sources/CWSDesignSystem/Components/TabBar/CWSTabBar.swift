import SwiftUI

/// One destination in a ``CWSTabBar``.
public struct CWSTabItem: Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let systemImage: String

    public init(id: Int, title: String, systemImage: String) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
    }
}

/// A themed bottom tab bar. Selection is hoisted via the `selection` binding (matched against each
/// item's `id`). Place it at the bottom of your layout.
///
/// ```swift
/// CWSTabBar(selection: $tab, items: [
///     .init(id: 0, title: "Home", systemImage: "house"),
///     .init(id: 1, title: "Saved", systemImage: "bookmark"),
/// ])
/// ```
public struct CWSTabBar: View {
    @Environment(\.cwsTheme) private var theme

    @Binding private var selection: Int
    private let items: [CWSTabItem]

    public init(selection: Binding<Int>, items: [CWSTabItem]) {
        self._selection = selection
        self.items = items
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(items) { item in
                Button { selection = item.id } label: {
                    VStack(spacing: CWSSpacing.xxs) {
                        Image(systemName: item.systemImage)
                            .font(.system(size: 20))
                            .accessibilityHidden(true)
                        Text(item.title)
                            .font(CWSTypography.labelSmall)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(item.id == selection ? theme.colorScheme.primary : theme.colorScheme.outline)
                }
                .buttonStyle(.plain)
                .frame(minHeight: CWSAccessibility.minTapTarget)
                .accessibilityLabel(Text(item.title))
                .accessibilityAddTraits(item.id == selection ? [.isButton, .isSelected] : .isButton)
            }
        }
        .padding(.vertical, CWSSpacing.xs)
        .background(theme.colorScheme.surface)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(theme.colorScheme.outline)
                .frame(height: 0.5)
        }
    }
}

#Preview("Light") {
    CWSTabBarPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSTabBarPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSTabBarPreview: View {
    @State private var tab = 0

    var body: some View {
        VStack {
            Spacer()
            CWSTabBar(selection: $tab, items: [
                .init(id: 0, title: "Home", systemImage: "house"),
                .init(id: 1, title: "Explore", systemImage: "map"),
                .init(id: 2, title: "Saved", systemImage: "bookmark"),
                .init(id: 3, title: "Profile", systemImage: "person")
            ])
        }
    }
}
