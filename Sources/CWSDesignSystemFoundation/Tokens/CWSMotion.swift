import SwiftUI

/// Motion tokens — standard animation curves/durations for the system.
///
/// Honor `@Environment(\.accessibilityReduceMotion)` at the call site before applying these.
public enum CWSMotion {
    public static let short = Animation.easeInOut(duration: 0.15)
    public static let medium = Animation.easeInOut(duration: 0.25)
    public static let long = Animation.easeInOut(duration: 0.40)
}
