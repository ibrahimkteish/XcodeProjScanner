# XcodeProjScanner

The main goal of this tool is to scan an iOS project and try to find all the unreferenced `.swift` files.

## Usage

`xcode-proj-scanner --path <path> [--xcodeproj <xcodeproj>]`

```
OPTIONS:
  --path <path>           Specify the iOS project path
  --xcodeproj <xcodeproj> Specify the iOS project .xcodeproj path (Optional)
  -h, --help              Show help information.
```

## Example

```
XcodeProjScanner --path /Users/ibrahimkoteish/Documents/Glovo/iOS/glovo-courier-ios/GlovoCourier --xcodeproj /Users/ibrahimkoteish/Documents/Glovo/iOS/glovo-courier-ios/GlovoCourier/GlovoCourier.xcodeproj/project.pbxproj

```

or 

```
XcodeProjScanner --path /Users/ibrahimkoteish/Documents/Glovo/iOS/glovo-courier-ios/GlovoCourier

```
