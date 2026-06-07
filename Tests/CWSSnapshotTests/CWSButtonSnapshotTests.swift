#if canImport(UIKit)
import SnapshotTesting
import SwiftUI
import Testing
import UIKit
@testable import CWSDesignSystem

/// Golden image tests for `CWSButton`. Run on an iOS simulator via `xcodebuild test`.
/// First run records goldens (set `SNAPSHOT_TESTING_RECORD=all`); commit the `__Snapshots__` dir.
@MainActor
@Suite("CWSButton snapshots")
struct CWSButtonSnapshotTests {
    private func gallery(_ theme: CWSTheme) -> some View {
        VStack(spacing: CWSSpacing.md) {
            CWSButton("Primary") {}
            CWSButton("Secondary", variant: .secondary) {}
            CWSButton("Ghost", variant: .ghost) {}
            CWSButton("Danger", variant: .danger) {}
            CWSButton("With icon", systemImage: "arrow.right") {}
        }
        .padding()
        .background(theme.colorScheme.background)
        .cwsTheme(theme)
    }

    @Test("Buttons — light")
    func light() {
        let vc = UIHostingController(rootView: gallery(.light))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    @Test("Buttons — dark")
    func dark() {
        let vc = UIHostingController(rootView: gallery(.dark).preferredColorScheme(.dark))
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }
}
#endif
