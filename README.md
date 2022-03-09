# XcodeProjScanner

The main goal of this tool is to scan an iOS project and try to find all the unreferenced `.swift` files.

## Usage

`xcode-proj-scanner --path <path> [--xcodeproj <xcodeproj>]`

```
OPTIONS:
  --path <path>           Specify the iOS project path
  --xcodeproj <xcodeproj> Specify the iOS project .xcodeproj/project.pbxproj path (Optional)
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

## Build the project

1. open terminal 
2. check out this project
3. cd into `XcodeProjScanner`
4. run swift build
5. run `./.build/debug/XcodeProjScanner --path <a-valid-path> --xcodeproj <a-valid-path-for-xcodeproj/project.pbxproj>`

## Xcode

after checking out and cd in the project folder, you can  run `xed .` from terminal to open the project in xcode.