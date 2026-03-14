import PackageDescription
let package = Package(name: "swift-extension-demo", platforms: [.macOS(.v10_15)], targets: [.executableTarget(name: "swift-extension-demo", path: "Sources")])
