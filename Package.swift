// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "swift-corelibs-multitasking",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "Multitasking",
            targets: ["Multitasking"]
        ),
        .executable(
            name: "multitasking-demo",
            targets: ["multitasking-demo"]
        )
    ],
    targets: [
        .target(
            name: "Multitasking",
            path: "Sources/Multitasking"
        ),
        .executableTarget(
            name: "multitasking-demo",
            dependencies: ["Multitasking"],
            path: "Sources/multitasking-demo"
        ),
        .testTarget(
            name: "MultitaskingTests",
            dependencies: ["Multitasking"],
            path: "tests",
            sources: [
                "core/TaskTests.swift",
                "core/TaskSchedulerTests.swift",
                "core/ThreadManagerTests.swift",
                "core/PerformanceMonitorTests.swift"
            ]
        )
    ]
)
