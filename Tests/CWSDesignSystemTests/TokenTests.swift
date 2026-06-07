import Testing
import CoreGraphics
@testable import CWSDesignSystemFoundation

@Suite("Design tokens")
struct TokenTests {
    @Test("Spacing scale increases monotonically")
    func spacingScale() {
        #expect(CWSSpacing.none < CWSSpacing.xs)
        #expect(CWSSpacing.xs < CWSSpacing.sm)
        #expect(CWSSpacing.sm < CWSSpacing.md)
        #expect(CWSSpacing.md < CWSSpacing.lg)
        #expect(CWSSpacing.lg < CWSSpacing.xl)
    }

    @Test("Radius full is a pill-sized value")
    func radiusFull() {
        #expect(CWSRadius.full >= 100)
        #expect(CWSRadius.md > CWSRadius.sm)
    }

    @Test("Shadow elevation increases with level")
    func shadowElevation() {
        #expect(CWSShadow.level1.radius < CWSShadow.level2.radius)
        #expect(CWSShadow.level2.radius < CWSShadow.level3.radius)
        #expect(CWSShadow.level0.color == .clear)
    }
}
