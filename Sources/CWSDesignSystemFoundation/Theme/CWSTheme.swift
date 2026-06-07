import SwiftUI

/// The active design-system theme: a semantic ``CWSColorScheme`` plus the shared design tokens
/// (spacing, typography, radius, shadow, motion are global token namespaces).
///
/// Inject it into the environment with `.cwsTheme(_:)` and read it with
/// `@Environment(\.cwsTheme)`.
public struct CWSTheme: Sendable, Equatable {
    public var colorScheme: CWSColorScheme

    public init(colorScheme: CWSColorScheme) {
        self.colorScheme = colorScheme
    }

    public static let light = CWSTheme(colorScheme: .light)
    public static let dark = CWSTheme(colorScheme: .dark)

    /// A light theme re-skinned with a custom brand color.
    public static func brand(_ color: Color) -> CWSTheme {
        CWSTheme(colorScheme: .light(primaryBrand: color))
    }
}
