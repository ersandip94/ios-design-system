import SwiftUI

/// Accessibility constants for the design system.
public enum CWSAccessibility {
    /// Apple Human Interface Guidelines minimum interactive target.
    public static let minTapTarget: CGFloat = 44
}

extension View {
    /// Guarantees at least a 44×44pt hit area (HIG minimum), even if the visual control is smaller.
    public func cwsMinimumTapTarget() -> some View {
        frame(minWidth: CWSAccessibility.minTapTarget, minHeight: CWSAccessibility.minTapTarget)
            .contentShape(Rectangle())
    }
}
