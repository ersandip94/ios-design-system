#if canImport(UIKit)
import SnapshotTesting
import SwiftUI
import Testing
import UIKit
@testable import CWSDesignSystem

/// Golden image tests for the component set. Run on an iOS simulator via `xcodebuild test`.
@MainActor
@Suite("Component snapshots")
struct ComponentSnapshotTests {
    private func snapshot(_ name: String, _ theme: CWSTheme, @ViewBuilder _ content: () -> some View) {
        let view = content()
            .padding()
            .frame(width: 320)
            .background(theme.colorScheme.background)
            .cwsTheme(theme)
            .preferredColorScheme(theme == .dark ? .dark : .light)
        assertSnapshot(of: UIHostingController(rootView: view), as: .image, named: name)
    }

    @Test("Badges")
    func badges() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                VStack(alignment: .leading, spacing: CWSSpacing.md) {
                    CWSBadge("New", status: .success)
                    CWSBadge("Beta", status: .info)
                    CWSCountBadge(count: 128)
                }
            }
        }
    }

    @Test("Chips")
    func chips() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                HStack {
                    CWSChip("Selected", isSelected: true) {}
                    CWSChip("Unselected") {}
                }
            }
        }
    }

    @Test("TextField")
    func textField() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                CWSTextField(
                    text: .constant("you@example.com"),
                    label: "Email",
                    leadingIcon: "envelope"
                )
            }
        }
    }

    @Test("Checkbox")
    func checkbox() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                VStack(alignment: .leading, spacing: CWSSpacing.md) {
                    CWSCheckbox("Checked", isOn: .constant(true))
                    CWSCheckbox("Unchecked", isOn: .constant(false))
                }
            }
        }
    }

    @Test("RadioGroup")
    func radioGroup() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                CWSRadioGroup(selection: .constant("Medium"), options: ["Small", "Medium", "Large"])
            }
        }
    }

    @Test("TopBar")
    func topBar() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                CWSTopBar("Reykjavík", onBack: {}) {
                    Image(systemName: "heart").accessibilityLabel(Text("Favorite"))
                }
            }
        }
    }

    @Test("TabBar")
    func tabBar() {
        for theme in [CWSTheme.light, .dark] {
            snapshot(theme == .dark ? "dark" : "light", theme) {
                CWSTabBar(selection: .constant(0), items: [
                    .init(id: 0, title: "Home", systemImage: "house"),
                    .init(id: 1, title: "Explore", systemImage: "map"),
                    .init(id: 2, title: "Saved", systemImage: "bookmark"),
                ])
            }
        }
    }
}
#endif
