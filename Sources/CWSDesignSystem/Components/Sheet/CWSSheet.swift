import SwiftUI

extension View {
    /// Presents a themed bottom sheet with resizable detents.
    ///
    /// The sheet content is re-injected with the active `CWSTheme` (sheets present in a separate
    /// environment), and gets a themed background + drag indicator.
    ///
    /// ```swift
    /// screen.cwsSheet(isPresented: $showingFilters) {
    ///     FiltersView()
    /// }
    /// ```
    public func cwsSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        detents: Set<PresentationDetent> = [.medium, .large],
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        modifier(
            CWSSheetModifier(isPresented: isPresented, detents: detents, sheetContent: content)
        )
    }
}

private struct CWSSheetModifier<SheetContent: View>: ViewModifier {
    @Environment(\.cwsTheme) private var theme

    @Binding var isPresented: Bool
    let detents: Set<PresentationDetent>
    @ViewBuilder let sheetContent: () -> SheetContent

    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            ZStack {
                theme.colorScheme.surface
                    .ignoresSafeArea()
                ScrollView {
                    sheetContent()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(CWSSpacing.lg)
                }
            }
            .presentationDetents(detents)
            .presentationDragIndicator(.visible)
            .cwsTheme(theme)
        }
    }
}

#Preview("Light") {
    CWSSheetPreview()
        .cwsTheme(.light)
}

private struct CWSSheetPreview: View {
    @State private var showing = false

    var body: some View {
        CWSButton("Show sheet") { showing = true }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cwsSheet(isPresented: $showing) {
                VStack(alignment: .leading, spacing: CWSSpacing.md) {
                    Text("Filters").font(CWSTypography.titleLarge)
                    CWSToggle("Open now", isOn: .constant(true))
                    CWSButton("Apply") { showing = false }
                }
            }
    }
}
