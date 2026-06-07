import Testing
import SwiftUI
@testable import CWSDesignSystemFoundation

@Suite("Theme")
struct ThemeTests {
    @Test("Custom brand overrides the primary role")
    func brandOverride() {
        let theme = CWSTheme.brand(.purple)
        #expect(theme.colorScheme.primary == Color.purple)
        // Non-primary roles are untouched by a brand re-skin.
        #expect(theme.colorScheme.surface == CWSColorScheme.light.surface)
    }

    @Test("Light and dark schemes differ in background")
    func lightDarkDiffer() {
        #expect(CWSColorScheme.light.background != CWSColorScheme.dark.background)
        #expect(CWSColorScheme.light.onBackground != CWSColorScheme.dark.onBackground)
    }

    @Test("Default theme is light")
    func defaultIsLight() {
        #expect(CWSTheme.light.colorScheme == CWSColorScheme.light)
    }
}
