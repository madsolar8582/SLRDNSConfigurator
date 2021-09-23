// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SLRDNSConfigurator",
    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "SLRDNSConfigurator", targets: ["SLRDNSConfigurator"]
        )
    ],
    targets: [
        .target(
            name: "SLRDNSConfigurator",
            path: ".",
            sources: ["SLRDNSConfigurator"],
            publicHeadersPath: "SLRDNSConfigurator"
        ),
        .testTarget(
            name: "SLRDNSConfiguratorTests",
            dependencies: ["SLRDNSConfigurator"],
            path: ".",
            sources: ["SLRDNSConfiguratorTests"]
        )
    ]
)
