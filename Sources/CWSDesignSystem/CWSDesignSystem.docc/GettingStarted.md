# Getting Started

Add CWS to your project and render your first themed component.

## Install

In Xcode: **File ▸ Add Package Dependencies…** and paste the repository URL. Or add it to your
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ersandip94/codewithsandip-ds-ios", from: "1.0.0"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "CWSDesignSystem", package: "codewithsandip-ds-ios"),
    ]),
]
```

A single `import CWSDesignSystem` brings in the components *and* the re-exported
`CWSDesignSystemFoundation` tokens and theming.

## Theme your app

Inject a theme once, near the root of your view tree. Everything below it inherits it:

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

## Use components

Components are stateless — you own the state and pass it in:

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

## Next steps

- <doc:Theming> — colors, dark mode, and custom brands
- <doc:APIDesign> — the conventions every component follows
