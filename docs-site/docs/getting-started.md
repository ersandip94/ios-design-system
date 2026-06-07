# Get started

Requirements: **iOS 18+**, **Swift 6 / Xcode 16+**.

## 1. Add the package

In Xcode: **File ▸ Add Package Dependencies…** and paste the repo URL. Or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ersandip94/ios-design-system", from: "1.0.0"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "CWSDesignSystem", package: "ios-design-system"),
    ]),
]
```

A single `import CWSDesignSystem` brings in the components **and** the re-exported
`CWSDesignSystemFoundation` tokens and theming.

## 2. Inject a theme

Set the theme once, near the root. Everything below inherits it via the environment (`@Entry`):

```swift
import CWSDesignSystem

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .cwsTheme(.light)   // .dark, or .brand(.purple) to re-skin everything
        }
    }
}
```

## 3. Use components

Components are stateless — you own the state and pass it in via `@Binding`:

```swift
struct SignInView: View {
    @State private var email = ""
    @State private var agreed = false

    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSTextField(text: $email, label: "Email", leadingIcon: "envelope")
            CWSCheckbox("I agree to the terms", isOn: $agreed)
            CWSButton("Continue", systemImage: "arrow.right") { /* … */ }
        }
        .padding()
    }
}
```

!!! tip
    Re-skin the entire system with one line — `.cwsTheme(.brand(Color(red: 0.4, green: 0.2, blue: 0.8)))`.
    See [Custom brand](theming/custom-brand.md).
