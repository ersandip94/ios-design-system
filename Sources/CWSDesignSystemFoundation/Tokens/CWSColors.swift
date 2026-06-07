import SwiftUI

/// Primitive palette — raw brand and neutral ramps plus status hues.
///
/// Prefer the *semantic* roles on ``CWSColorScheme`` (e.g. `primary`, `onSurface`) in component
/// code; reach for these primitives only when defining a scheme.
public enum CWSColors {
    // Brand (green) — anchored on the Android system's `#0C3A25`.
    public static let brand900 = Color(red: 0.047, green: 0.227, blue: 0.145)
    public static let brand700 = Color(red: 0.094, green: 0.392, blue: 0.255)
    public static let brand500 = Color(red: 0.176, green: 0.561, blue: 0.376)
    public static let brand300 = Color(red: 0.498, green: 0.745, blue: 0.604)
    public static let brand50 = Color(red: 0.910, green: 0.961, blue: 0.933)

    // Neutrals.
    public static let neutral900 = Color(red: 0.106, green: 0.106, blue: 0.118)
    public static let neutral800 = Color(red: 0.145, green: 0.145, blue: 0.157)
    public static let neutral700 = Color(red: 0.282, green: 0.282, blue: 0.302)
    public static let neutral500 = Color(red: 0.557, green: 0.557, blue: 0.576)
    public static let neutral300 = Color(red: 0.776, green: 0.776, blue: 0.792)
    public static let neutral100 = Color(red: 0.937, green: 0.937, blue: 0.945)
    public static let neutral50 = Color(red: 0.969, green: 0.969, blue: 0.973)

    // Status.
    public static let error = Color(red: 0.812, green: 0.235, blue: 0.231)
    public static let warning = Color(red: 0.918, green: 0.620, blue: 0.196)
    public static let success = Color(red: 0.176, green: 0.561, blue: 0.376)
    public static let info = Color(red: 0.184, green: 0.459, blue: 0.812)
}
