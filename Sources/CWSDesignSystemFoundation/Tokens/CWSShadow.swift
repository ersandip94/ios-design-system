import SwiftUI

/// Elevation tokens expressed as drop shadows. Apply with `.cwsShadow(_:)`.
public struct CWSShadow: Sendable, Equatable {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat

    public init(color: Color, radius: CGFloat, x: CGFloat = 0, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    public static let level0 = CWSShadow(color: .clear, radius: 0, y: 0)
    public static let level1 = CWSShadow(color: .black.opacity(0.12), radius: 2, y: 1)
    public static let level2 = CWSShadow(color: .black.opacity(0.14), radius: 6, y: 3)
    public static let level3 = CWSShadow(color: .black.opacity(0.16), radius: 12, y: 6)
}

extension View {
    /// Applies a ``CWSShadow`` elevation token.
    public func cwsShadow(_ shadow: CWSShadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
    }
}
