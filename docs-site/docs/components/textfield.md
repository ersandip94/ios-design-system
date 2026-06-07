# Text field

A themed text field with an optional label, leading icon, helper text, and error state. State is
hoisted via a `Binding`.

```swift
@State private var email = ""

CWSTextField(
    text: $email,
    label: "Email",
    placeholder: "you@example.com",
    helperText: "We'll never share it.",
    leadingIcon: "envelope"
)
```

## Secure entry

```swift
CWSTextField(text: $password, label: "Password", isSecure: true, leadingIcon: "lock")
```

## Error state

When `isError` is `true`, the border turns to the `error` role and `errorText` replaces the helper
text:

```swift
CWSTextField(
    text: $username,
    label: "Username",
    errorText: "That username is taken.",
    isError: true
)
```

!!! note "Accessibility"
    The field is a combined accessibility element labeled by `label` (falling back to `placeholder`).
    Disabled fields dim to 0.38 opacity.
