import Testing
import SwiftUI
@testable import CWSDesignSystemFoundation

@Suite("Contrast (WCAG)")
struct ContrastTests {
    @Test("Black on white exceeds AA")
    func blackOnWhite() {
        #expect(Color.black.cwsMeetsContrast(against: .white, ratio: 4.5))
        #expect(Color.black.cwsContrastRatio(against: .white) > 20)
    }

    @Test("White on white fails contrast")
    func whiteOnWhite() {
        #expect(!Color.white.cwsMeetsContrast(against: .white))
    }

    @Test("Primary container text is at least AA-large")
    func onContainerReadable() {
        let scheme = CWSColorScheme.light
        // brand900 text on brand50 container should be comfortably readable.
        #expect(scheme.onPrimaryContainer.cwsContrastRatio(against: scheme.primaryContainer) >= 3.0)
    }
}
