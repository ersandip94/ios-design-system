import SwiftUI

/// Semantic color roles consumed by components. Build one with ``light``, ``dark``, or
/// ``light(primaryBrand:)`` for a custom re-skin.
public struct CWSColorScheme: Sendable, Equatable {
    public var primary: Color
    public var onPrimary: Color
    public var primaryContainer: Color
    public var onPrimaryContainer: Color
    public var background: Color
    public var onBackground: Color
    public var surface: Color
    public var onSurface: Color
    public var surfaceVariant: Color
    public var outline: Color
    public var error: Color
    public var onError: Color

    public init(
        primary: Color,
        onPrimary: Color,
        primaryContainer: Color,
        onPrimaryContainer: Color,
        background: Color,
        onBackground: Color,
        surface: Color,
        onSurface: Color,
        surfaceVariant: Color,
        outline: Color,
        error: Color,
        onError: Color
    ) {
        self.primary = primary
        self.onPrimary = onPrimary
        self.primaryContainer = primaryContainer
        self.onPrimaryContainer = onPrimaryContainer
        self.background = background
        self.onBackground = onBackground
        self.surface = surface
        self.onSurface = onSurface
        self.surfaceVariant = surfaceVariant
        self.outline = outline
        self.error = error
        self.onError = onError
    }
}

extension CWSColorScheme {
    /// The default light scheme.
    public static let light = CWSColorScheme(
        primary: CWSColors.brand500,
        onPrimary: .white,
        primaryContainer: CWSColors.brand50,
        onPrimaryContainer: CWSColors.brand900,
        background: CWSColors.neutral50,
        onBackground: CWSColors.neutral900,
        surface: .white,
        onSurface: CWSColors.neutral900,
        surfaceVariant: CWSColors.neutral100,
        outline: CWSColors.neutral300,
        error: CWSColors.error,
        onError: .white
    )

    /// The default dark scheme.
    public static let dark = CWSColorScheme(
        primary: CWSColors.brand300,
        onPrimary: CWSColors.brand900,
        primaryContainer: CWSColors.brand700,
        onPrimaryContainer: CWSColors.brand50,
        background: CWSColors.neutral900,
        onBackground: CWSColors.neutral50,
        surface: CWSColors.neutral800,
        onSurface: CWSColors.neutral50,
        surfaceVariant: CWSColors.neutral700,
        outline: CWSColors.neutral500,
        error: Color(red: 0.95, green: 0.45, blue: 0.45),
        onError: CWSColors.neutral900
    )

    /// Re-skin the light scheme with a custom brand primary — no component changes needed.
    public static func light(primaryBrand: Color) -> CWSColorScheme {
        var scheme = CWSColorScheme.light
        scheme.primary = primaryBrand
        return scheme
    }
}
