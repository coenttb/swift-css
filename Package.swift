// swift-tools-version:5.10.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let css: Self = "CSS"
}

extension Target.Dependency {
    static var css: Self { .target(name: .css) }
}

extension Target.Dependency {
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
}

extension [Package.Dependency] {
    static var `default`: Self {
        [
            .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.5"),
        ]
    }
}

struct CustomTarget {
    let name: String
    var library: Bool = true
    var dependencies: [Target.Dependency] = []
}

extension Package {
    static func html(
        targets: [CustomTarget]
    ) -> Package {
        return Package(
            name: "swift-css",
            platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
            products: [
                [
                    .library(name: .css, targets: [.css]),
                ]
            ].flatMap { $0
            },
            dependencies: .default,
            targets: [
                targets.map { target in
                    Target.target(
                        name: "\(target.name)",
                        dependencies: [] + target.dependencies
                    )
                },
                targets.map { target in
                    Target.testTarget(
                        name: "\(target.name) Tests",
                        dependencies: [.init(stringLiteral: target.name)]
                    )
                }
            ].flatMap { $0 }
        )
    }
}

let package = Package.html(
    targets: [
        .init(
            name: .css,
            library: true,
            dependencies: [
                .dependencies
            ]
        ),
    ]
)
