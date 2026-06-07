# Dark mode

Because components read **semantic roles** from the injected `CWSColorScheme`, dark mode is just a
different scheme — no component changes required.

## Pick a scheme

```swift
RootView().cwsTheme(.dark)    // force dark
RootView().cwsTheme(.light)   // force light
```

## Follow the system setting

Drive the CWS theme from SwiftUI's environment color scheme:

```swift
struct RootView: View {
    @Environment(\.colorScheme) private var system

    var body: some View {
        ContentView()
            .cwsTheme(system == .dark ? .dark : .light)
    }
}
```

!!! tip "Preview both at once"
    Every component ships light and dark `#Preview`s:

    ```swift
    #Preview("Dark") {
        MyView()
            .cwsTheme(.dark)
            .preferredColorScheme(.dark)
    }
    ```

The dark scheme adjusts every role (e.g. `primary` shifts to a lighter brand tint, `surface` to a
dark elevated gray) so contrast holds — verified by dark-mode [snapshot tests](../engineering/testing.md).
