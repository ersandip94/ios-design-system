import CWSDesignSystem
import SwiftUI

struct ButtonGalleryScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: CWSSpacing.md) {
                CWSButton("Primary") {}
                CWSButton("Secondary", variant: .secondary) {}
                CWSButton("Ghost", variant: .ghost) {}
                CWSButton("Danger", variant: .danger) {}
                CWSButton("With icon", systemImage: "arrow.right") {}
                CWSButton("Loading", isLoading: true) {}
                CWSButton("Disabled") {}.disabled(true)

                Divider()

                CWSButton("Small", size: .small) {}
                CWSButton("Large", size: .large) {}
            }
            .padding()
        }
        .navigationTitle("Button")
    }
}

struct CardGalleryScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: CWSSpacing.md) {
                CWSCard {
                    Text("Elevated").font(CWSTypography.titleMedium)
                    Text("A raised surface with a shadow.")
                }
                CWSCard(variant: .outlined) {
                    Text("Outlined").font(CWSTypography.titleMedium)
                    Text("A flat surface with a hairline border.")
                }
                CWSCard(variant: .filled) {
                    Text("Filled").font(CWSTypography.titleMedium)
                    Text("Tinted with the primary container color.")
                }
            }
            .padding()
        }
        .navigationTitle("Card")
    }
}

struct TextFieldGalleryScreen: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ScrollView {
            VStack(spacing: CWSSpacing.md) {
                CWSTextField(
                    text: $email,
                    label: "Email",
                    placeholder: "you@example.com",
                    helperText: "We'll never share it.",
                    leadingIcon: "envelope"
                )
                CWSTextField(text: $password, label: "Password", isSecure: true, leadingIcon: "lock")
                CWSTextField(
                    text: .constant("taken"),
                    label: "Username",
                    errorText: "That username is taken.",
                    isError: true
                )
            }
            .padding()
        }
        .navigationTitle("Text field")
    }
}

struct BadgeGalleryScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CWSSpacing.md) {
                HStack(spacing: CWSSpacing.md) {
                    CWSBadge(status: .error)
                    CWSBadge(status: .success)
                    CWSBadge(status: .info)
                }
                CWSBadge("New", status: .success)
                CWSBadge("Beta", status: .info)
                CWSBadge("Deprecated", status: .warning)
                CWSCountBadge(count: 7)
                CWSCountBadge(count: 128)
            }
            .padding()
        }
        .navigationTitle("Badge")
    }
}

struct ChipGalleryScreen: View {
    @State private var selected = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CWSSpacing.md) {
                CWSChip("Beaches", isSelected: selected) { selected.toggle() }
                CWSChip("Mountains", systemImage: "mountain.2") {}
                CWSChip("kotlin", variant: .input, onClose: {}, action: {})
                CWSChip("Add filter", variant: .suggestion, systemImage: "plus") {}
            }
            .padding()
        }
        .navigationTitle("Chip")
    }
}

struct ToggleGalleryScreen: View {
    @State private var notifications = true
    @State private var marketing = false

    var body: some View {
        ScrollView {
            VStack(spacing: CWSSpacing.md) {
                CWSToggle("Notifications", isOn: $notifications)
                CWSToggle("Marketing emails", isOn: $marketing)
            }
            .padding()
        }
        .navigationTitle("Toggle")
    }
}

struct SliderGalleryScreen: View {
    @State private var volume = 0.6
    @State private var brightness = 40.0

    var body: some View {
        ScrollView {
            VStack(spacing: CWSSpacing.lg) {
                CWSSlider(value: $volume, label: "Volume")
                CWSSlider(value: $brightness, in: 0...100, step: 5, label: "Brightness")
            }
            .padding()
        }
        .navigationTitle("Slider")
    }
}

struct SelectionGalleryScreen: View {
    @State private var terms = true
    @State private var newsletter = false
    @State private var size = "Medium"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CWSSpacing.lg) {
                VStack(alignment: .leading, spacing: CWSSpacing.md) {
                    CWSCheckbox("I agree to the terms", isOn: $terms)
                    CWSCheckbox("Subscribe to the newsletter", isOn: $newsletter)
                }
                Divider()
                CWSRadioGroup(selection: $size, options: ["Small", "Medium", "Large"])
            }
            .padding()
        }
        .navigationTitle("Checkbox & Radio")
    }
}

struct OverlayGalleryScreen: View {
    @State private var showingDialog = false
    @State private var showingSheet = false

    var body: some View {
        VStack(spacing: CWSSpacing.md) {
            CWSButton("Show dialog", variant: .danger) { showingDialog = true }
            CWSButton("Show sheet", variant: .secondary) { showingSheet = true }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Dialog & Sheet")
        .cwsDialog(
            isPresented: $showingDialog,
            title: "Delete account?",
            message: "This action can't be undone.",
            confirmLabel: "Delete",
            variant: .destructive
        ) {}
        .cwsSheet(isPresented: $showingSheet) {
            VStack(alignment: .leading, spacing: CWSSpacing.md) {
                Text("Filters").font(CWSTypography.titleLarge)
                CWSToggle("Open now", isOn: .constant(true))
                CWSButton("Apply") { showingSheet = false }
            }
        }
    }
}

struct NavigationGalleryScreen: View {
    @State private var tab = 0

    var body: some View {
        VStack(spacing: 0) {
            CWSTopBar("Reykjavík", onBack: {}, trailing: {
                Button {} label: {
                    Image(systemName: "heart")
                        .accessibilityLabel(Text("Favorite"))
                }
                .buttonStyle(.plain)
            })

            ScrollView {
                VStack(spacing: CWSSpacing.md) {
                    ForEach(0..<6) { index in
                        CWSCard {
                            Text("Row \(index + 1)").font(CWSTypography.titleMedium)
                        }
                    }
                }
                .padding()
            }

            CWSTabBar(selection: $tab, items: [
                .init(id: 0, title: "Home", systemImage: "house"),
                .init(id: 1, title: "Explore", systemImage: "map"),
                .init(id: 2, title: "Saved", systemImage: "bookmark"),
                .init(id: 3, title: "Profile", systemImage: "person")
            ])
        }
        .navigationBarHidden(true)
    }
}
