// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Spatial",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "Spatial",
            targets: ["Spatial"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Spatial",
            dependencies: []),
        .testTarget(
            name: "SpatialTests",
            dependencies: ["Spatial"])
    ]
)
