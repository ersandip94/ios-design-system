import SwiftUI

/// A themed text field with an optional label, leading icon, helper text, and error state.
///
/// State is hoisted: pass a `Binding` for `text`. Supports a secure (password) mode.
///
/// ```swift
/// CWSTextField(text: $email, label: "Email", placeholder: "you@example.com", leadingIcon: "envelope")
/// ```
public struct CWSTextField: View {
    @Environment(\.cwsTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var text: String
    private let label: String?
    private let placeholder: String?
    private let helperText: String?
    private let errorText: String?
    private let isError: Bool
    private let isSecure: Bool
    private let leadingIcon: String?

    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String? = nil,
        helperText: String? = nil,
        errorText: String? = nil,
        isError: Bool = false,
        isSecure: Bool = false,
        leadingIcon: String? = nil
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorText = errorText
        self.isError = isError
        self.isSecure = isSecure
        self.leadingIcon = leadingIcon
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.xs) {
            if let label {
                Text(label)
                    .font(CWSTypography.labelLarge)
                    .foregroundStyle(theme.colorScheme.onSurface)
            }

            HStack(spacing: CWSSpacing.sm) {
                if let leadingIcon {
                    Image(systemName: leadingIcon)
                        .foregroundStyle(theme.colorScheme.outline)
                        .accessibilityHidden(true)
                }
                field
                    .font(CWSTypography.bodyLarge)
                    .foregroundStyle(theme.colorScheme.onSurface)
            }
            .padding(.horizontal, CWSSpacing.md)
            .frame(minHeight: 48)
            .background(theme.colorScheme.surface, in: RoundedRectangle(cornerRadius: CWSRadius.md))
            .overlay {
                RoundedRectangle(cornerRadius: CWSRadius.md)
                    .strokeBorder(borderColor, lineWidth: 1)
            }

            if let supportingText {
                Text(supportingText)
                    .font(CWSTypography.labelSmall)
                    .foregroundStyle(isError ? theme.colorScheme.error : theme.colorScheme.outline)
            }
        }
        .opacity(isEnabled ? 1 : 0.38)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(label ?? placeholder ?? ""))
    }

    @ViewBuilder private var field: some View {
        if isSecure {
            SecureField(placeholder ?? "", text: $text)
        } else {
            TextField(placeholder ?? "", text: $text)
        }
    }

    private var borderColor: Color {
        isError ? theme.colorScheme.error : theme.colorScheme.outline
    }

    private var supportingText: String? {
        isError ? (errorText ?? helperText) : helperText
    }
}

#Preview("Light") {
    CWSTextFieldPreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSTextFieldPreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSTextFieldPreview: View {
    @State private var email = ""
    @State private var password = "secret"

    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSTextField(
                text: $email,
                label: "Email",
                placeholder: "you@example.com",
                helperText: "We'll never share it.",
                leadingIcon: "envelope"
            )
            CWSTextField(text: $password, label: "Password", isSecure: true, leadingIcon: "lock")
            CWSTextField(
                text: .constant("taken"),
                label: "Username",
                errorText: "That username is taken.",
                isError: true
            )
        }
        .padding()
    }
}
