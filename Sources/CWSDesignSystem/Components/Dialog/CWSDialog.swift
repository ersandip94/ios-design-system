import SwiftUI

/// Emphasis of a dialog's confirm action.
public enum CWSDialogVariant: Sendable {
    case standard
    case destructive
}

extension View {
    /// Presents a themed confirmation dialog over this view when `isPresented` is `true`.
    ///
    /// Best applied near a screen root so the scrim covers the whole screen. Reuses ``CWSButton``
    /// for its actions, so it inherits the system's button styling.
    ///
    /// ```swift
    /// screen.cwsDialog(
    ///     isPresented: $confirmingDelete,
    ///     title: "Delete account?",
    ///     message: "This can't be undone.",
    ///     confirmLabel: "Delete",
    ///     variant: .destructive,
    ///     onConfirm: viewModel.delete
    /// )
    /// ```
    public func cwsDialog(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        confirmLabel: String,
        cancelLabel: String? = "Cancel",
        variant: CWSDialogVariant = .standard,
        onConfirm: @escaping () -> Void
    ) -> some View {
        modifier(
            CWSDialogModifier(
                isPresented: isPresented,
                title: title,
                message: message,
                confirmLabel: confirmLabel,
                cancelLabel: cancelLabel,
                variant: variant,
                onConfirm: onConfirm
            )
        )
    }
}

private struct CWSDialogModifier: ViewModifier {
    @Environment(\.cwsTheme) private var theme

    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let confirmLabel: String
    let cancelLabel: String?
    let variant: CWSDialogVariant
    let onConfirm: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture { isPresented = false }
                        card
                            .padding(CWSSpacing.xl)
                    }
                    .transition(.opacity)
                }
            }
            .animation(CWSMotion.short, value: isPresented)
    }

    private var card: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.md) {
            Text(title)
                .font(CWSTypography.titleMedium)
                .foregroundStyle(theme.colorScheme.onSurface)
            if let message {
                Text(message)
                    .font(CWSTypography.bodyMedium)
                    .foregroundStyle(theme.colorScheme.onSurface.opacity(0.8))
            }
            HStack(spacing: CWSSpacing.sm) {
                Spacer()
                if let cancelLabel {
                    CWSButton(cancelLabel, variant: .ghost) { isPresented = false }
                }
                CWSButton(confirmLabel, variant: variant == .destructive ? .danger : .primary) {
                    isPresented = false
                    onConfirm()
                }
            }
        }
        .padding(CWSSpacing.lg)
        .frame(maxWidth: 400)
        .background(theme.colorScheme.surface, in: RoundedRectangle(cornerRadius: CWSRadius.lg))
        .cwsShadow(.level3)
        .accessibilityAddTraits(.isModal)
    }
}

#Preview("Light") {
    CWSDialogPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSDialogPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSDialogPreview: View {
    @State private var showing = true

    var body: some View {
        ZStack {
            CWSButton("Show dialog") { showing = true }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cwsDialog(
            isPresented: $showing,
            title: "Delete account?",
            message: "This action can't be undone.",
            confirmLabel: "Delete",
            variant: .destructive
        ) {}
    }
}
