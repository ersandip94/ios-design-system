import SwiftUI

extension EnvironmentValues {
    /// The active ``CWSTheme``. Inject with `.cwsTheme(_:)`; defaults to `.light`.
    @Entry public var cwsTheme: CWSTheme = .light
}

extension View {
    /// Injects a ``CWSTheme`` into the environment for all descendant CWS components.
    ///
    /// ```swift
    /// ContentView()
    ///     .cwsTheme(.dark)
    /// ```
    public func cwsTheme(_ theme: CWSTheme) -> some View {
        environment(\.cwsTheme, theme)
    }
}
