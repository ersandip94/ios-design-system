// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CWSDesignSystem",
    platforms: [
        .iOS(.v18),    // primary platform
        .macOS(.v14),  // the library is cross-platform; enables host build/test + macOS apps
    ],
    products: [
        // Umbrella library — `import CWSDesignSystem` re-exports the Foundation layer too.
        .library(name: "CWSDesignSystem", targets: ["CWSDesignSystem"]),
        .library(name: "CWSDesignSystemFoundation", targets: ["CWSDesignSystemFoundation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.0"),
        // SwiftLint (incl. the custom a11y rule in .swiftlint.yml) runs as a CI step / local
        // command — see CLAUDE.md. Kept out of the build graph so builds stay fast and offline-safe.
        // To wire it as a build-tool plugin instead, add:
        //   .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.0")
        // and attach `.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")`.
    ],
    targets: [
        // Layer 1 — tokens, theme, accessibility primitives. No component code, no dependencies.
        .target(
            name: "CWSDesignSystemFoundation"
        ),
        // Layer 2 — components. Depends on (and re-exports) Foundation.
        .target(
            name: "CWSDesignSystem",
            dependencies: ["CWSDesignSystemFoundation"]
        ),
        // Swift Testing unit tests — token values, theme/color resolution, WCAG contrast.
        .testTarget(
            name: "CWSDesignSystemTests",
            dependencies: ["CWSDesignSystem"]
        ),
        // Snapshot (golden) tests — rendered component images, light + dark.
        .testTarget(
            name: "CWSSnapshotTests",
            dependencies: [
                "CWSDesignSystem",
                // iOS-only: image snapshots need UIKit, and it keeps the macOS host `swift test`
                // (unit tests) independent of the snapshot library.
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing",
                    condition: .when(platforms: [.iOS])
                ),
            ]
        ),
    ]
)
