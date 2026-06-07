import SwiftUI

/// A themed button — a *leaf* component: a text label with an optional leading SF Symbol and an
/// optional loading state. It intentionally has no free-form content slot so every button in the
/// app stays visually consistent.
///
/// ```swift
/// CWSButton("Continue", systemImage: "arrow.right") { submit() }
/// CWSButton("Delete", variant: .danger) { delete() }
/// ```
public struct CWSButton: View {
    private let title: String
    private let systemImage: String?
    private let variant: CWSButtonVariant
    private let size: CWSButtonSize
    private let isLoading: Bool
    private let action: () -> Void

    public init(
        _ title: String,
        systemImage: String? = nil,
        variant: CWSButtonVariant = .primary,
        size: CWSButtonSize = .medium,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.variant = variant
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: CWSSpacing.sm) {
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                } else if let systemImage {
                    Image(systemName: systemImage)
                        .accessibilityHidden(true)
                }
                Text(title)
            }
        }
        .buttonStyle(CWSButtonStyle(variant: variant, size: size))
        .disabled(isLoading)
        .accessibilityLabel(Text(title))
    }
}

#Preview("Light") {
    CWSButtonPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSButtonPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSButtonPreview: View {
    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSButton("Primary") {}
            CWSButton("Secondary", variant: .secondary) {}
            CWSButton("Ghost", variant: .ghost) {}
            CWSButton("Danger", variant: .danger) {}
            CWSButton("With icon", systemImage: "arrow.right") {}
            CWSButton("Loading", isLoading: true) {}
            CWSButton("Disabled") {}.disabled(true)
        }
        .padding()
    }
}
