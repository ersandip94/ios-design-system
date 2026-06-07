import SwiftUI

extension Color {
    /// Relative luminance per WCAG 2.x, using the platform-resolved linear sRGB components.
    public func cwsRelativeLuminance() -> Double {
        let resolved = resolve(in: EnvironmentValues())
        return 0.2126 * Double(resolved.linearRed)
            + 0.7152 * Double(resolved.linearGreen)
            + 0.0722 * Double(resolved.linearBlue)
    }

    /// The WCAG contrast ratio between this color and another (ranges 1...21).
    public func cwsContrastRatio(against other: Color) -> Double {
        let l1 = cwsRelativeLuminance()
        let l2 = other.cwsRelativeLuminance()
        let lighter = max(l1, l2)
        let darker = min(l1, l2)
        return (lighter + 0.05) / (darker + 0.05)
    }

    /// Whether contrast against `other` meets a target ratio (4.5 = WCAG AA for normal text).
    public func cwsMeetsContrast(against other: Color, ratio: Double = 4.5) -> Bool {
        cwsContrastRatio(against: other) >= ratio
    }
}
