# Dialog

A themed confirmation dialog, presented as a **view modifier** driven by an `isPresented` binding.
It composes `CWSButton` for its actions, so it inherits the system's button styling.

```swift
@State private var confirmingDelete = false

screen
    .cwsDialog(
        isPresented: $confirmingDelete,
        title: "Delete account?",
        message: "This action can't be undone.",
        confirmLabel: "Delete",
        variant: .destructive,
        onConfirm: { viewModel.delete() }
    )
```

## Parameters

- `title`, `message` — heading and optional body.
- `confirmLabel` / `cancelLabel` — action labels (`cancelLabel` defaults to `"Cancel"`; pass `nil`
  to hide it).
- `variant` — `.standard` (primary confirm) or `.destructive` (danger confirm).
- `onConfirm` — called after the dialog dismisses.

!!! tip "Apply near a screen root"
    The dialog renders as a full-screen scrim + card overlay, so attach `.cwsDialog` high in the
    view tree. It's marked `.isModal` for assistive tech.
