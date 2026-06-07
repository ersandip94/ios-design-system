import SwiftUI

/// Semantic font tokens, backed by Dynamic Type text styles so they scale with the user's
/// preferred content size automatically.
public enum CWSTypography {
    public static let displayLarge = Font.system(.largeTitle, weight: .bold)
    public static let titleLarge = Font.system(.title, weight: .semibold)
    public static let titleMedium = Font.system(.title2, weight: .semibold)
    public static let bodyLarge = Font.system(.body)
    public static let bodyMedium = Font.system(.callout)
    public static let labelLarge = Font.system(.subheadline, weight: .semibold)
    public static let labelSmall = Font.system(.caption)
}
