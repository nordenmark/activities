# app

## Deploy to device

```
// Make a note of the device id
flutter devices
// Deploy to device
flutter run -d <device id> --release
```

## Signing error

```
open ios/Runner.xcodeproj
```

- Select Runner and go in under Signing & Capabilities to verify the signing certificate
