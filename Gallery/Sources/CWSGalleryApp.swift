import CWSDesignSystem
import SwiftUI

@main
struct CWSGalleryApp: App {
    @State private var isDark = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    NavigationLink("Button") { ButtonGalleryScreen() }
                    NavigationLink("Text field") { TextFieldGalleryScreen() }
                    NavigationLink("Card") { CardGalleryScreen() }
                    NavigationLink("Badge") { BadgeGalleryScreen() }
                    NavigationLink("Chip") { ChipGalleryScreen() }
                    NavigationLink("Toggle") { ToggleGalleryScreen() }
                    NavigationLink("Checkbox & Radio") { SelectionGalleryScreen() }
                    NavigationLink("Slider") { SliderGalleryScreen() }
                    NavigationLink("Dialog & Sheet") { OverlayGalleryScreen() }
                    NavigationLink("Top bar & Tab bar") { NavigationGalleryScreen() }
                }
                .navigationTitle("CWS Gallery")
                .toolbar {
                    Button(isDark ? "Light" : "Dark") { isDark.toggle() }
                }
            }
            .cwsTheme(isDark ? .dark : .light)
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}
