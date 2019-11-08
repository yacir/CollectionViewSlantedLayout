// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "CollectionViewSlantedLayout",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "CollectionViewSlantedLayout", targets: ["CollectionViewSlantedLayout"])
    ],
    targets: [
        .target(name: "CollectionViewSlantedLayout", path: "Sources"),
        .testTarget(name: "CollectionViewSlantedLayoutTests", dependencies: ["CollectionViewSlantedLayout"] , path: "Tests")
    ]
)
