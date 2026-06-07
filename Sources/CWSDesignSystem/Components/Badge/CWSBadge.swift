import SwiftUI

/// Semantic status of a ``CWSBadge``.
public enum CWSBadgeStatus: Sendable {
    case neutral
    case info
    case success
    case warning
    case error
}

/// A status indicator. Renders as a small **dot** when `text` is `nil`, or as a labeled **pill**
/// when text is provided.
///
/// ```swift
/// CWSBadge()                              // red dot
/// CWSBadge("New", status: .success)       // green pill
/// ```
public struct CWSBadge: View {
    private let text: String?
    private let status: CWSBadgeStatus

    public init(_ text: String? = nil, status: CWSBadgeStatus = .error) {
        self.text = text
        self.status = status
    }

    public var body: some View {
        Group {
            if let text {
                Text(text)
                    .font(CWSTypography.labelSmall.weight(.semibold))
                    .padding(.horizontal, CWSSpacing.sm)
                    .padding(.vertical, CWSSpacing.xxs)
                    .foregroundStyle(foreground)
                    .background(background, in: Capsule())
            } else {
                Circle()
                    .fill(background)
                    .frame(width: 10, height: 10)
            }
        }
        .accessibilityLabel(Text(text ?? "New"))
    }

    private var background: Color {
        switch status {
        case .neutral: CWSColors.neutral500
        case .info: CWSColors.info
        case .success: CWSColors.success
        case .warning: CWSColors.warning
        case .error: CWSColors.error
        }
    }

    private var foreground: Color {
        status == .warning ? .black : .white
    }
}

/// A numeric badge that clamps to `"\(max)+"` and hides itself when the count is zero.
///
/// ```swift
/// CWSCountBadge(count: 128)   // "99+"
/// ```
public struct CWSCountBadge: View {
    private let count: Int
    private let max: Int
    private let status: CWSBadgeStatus

    public init(count: Int, max: Int = 99, status: CWSBadgeStatus = .error) {
        self.count = count
        self.max = max
        self.status = status
    }

    public var body: some View {
        CWSBadge(count > max ? "\(max)+" : "\(count)", status: status)
            .opacity(count > 0 ? 1 : 0)
            .accessibilityLabel(Text("\(count) items"))
    }
}

#Preview("Light") {
    CWSBadgePreview()
        .cwsTheme(.light)
}

#Preview("Dark") {
    CWSBadgePreview()
        .cwsTheme(.dark)
        .preferredColorScheme(.dark)
}

private struct CWSBadgePreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: CWSSpacing.md) {
            HStack(spacing: CWSSpacing.md) {
                CWSBadge(status: .error)
                CWSBadge(status: .success)
                CWSBadge(status: .info)
            }
            CWSBadge("New", status: .success)
            CWSBadge("Beta", status: .info)
            CWSBadge("Deprecated", status: .warning)
            CWSCountBadge(count: 7)
            CWSCountBadge(count: 128)
        }
        .padding()
    }
}
