# swift-css
A Swift DSL for type-safe, extensible, and transformable CSS styles.

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

🚧 **This package is under active development** 🚧

This Swift package is currently in active development and is subject to frequent changes. Features and APIs may change without prior notice until a stable release is available.

swift-css is a Swift package that provides a comprehensive domain model for CSS properties and values. It allows you to work with CSS concepts in a type-safe, Swift-friendly manner, enabling powerful and precise styling in your Swift projects.

* [What is swift-css?](#what-is-swift-css)
* [Features](#features)
* [Basic usage](#basic-usage)
* [Documentation](#documentation)
* [Installation](#installation)

## What is swift-css?

swift-css offers a set of Swift types and structures that model various CSS concepts:

* **CSS Properties**: Type-safe representations of CSS properties like `Color`, `Font`, `Margin`, `Padding`, etc.
* **CSS Values**: Strongly-typed values for CSS properties, including lengths, colors, and keywords.
* **Layout Properties**: Support for Flexbox and other layout concepts.
* **Animations and Transitions**: Types for dealing with CSS animations and transitions.

This library allows Swift developers to work with CSS concepts using native Swift syntax and type safety, reducing errors and improving the developer experience when dealing with styles in Swift applications.

## Features

* **Type-safe CSS properties**: Define and manipulate CSS properties using Swift types, eliminating typos and ensuring valid values.
* **Comprehensive coverage**: Support for a wide range of CSS properties including colors, fonts, layouts, animations, and more.
* **Swift-native syntax**: Work with CSS concepts using familiar Swift syntax and conventions.
* **Extensible**: Easy to extend with new CSS properties or custom values.
* **Value conversions**: Convert between different units and formats where appropriate.

## Basic usage

Here's a quick example of how you might use swift-css:

```swift
import SwiftCSS

let backgroundColor = CSS.Color.rgba(red: 100, green: 149, blue: 237, alpha: 1)
let fontSize = 24.px
let font = Margin.all(Length.px(10))

let buttonStyle = Style(
  backgroundColor: .hex("#007AFF"),
  padding: Padding.all(Length.px(10)),
  borderRadius: BorderRadius(Length.px(5))
)

print(backgroundColor)  // Outputs: rgb(100, 149, 237)
print(fontSize)         // Outputs: 24px
print(margin)           // Outputs: 10px
print(buttonStyle)      // Outputs: background-color: #007AFF; padding: 10px; border-radius: 5px;
```

## Recommended use with swift-html

See [swift-html](https://github.com/coenttb/swift-html) for an example of how to use `swift-css`. `swift-html` uses `swift-css` as its model and provides convenience methods to easily and safely add inlineStyles to some HTML element.

## Installation

To install the package, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-css.git", from: "0.1.0")
]
```

You can then make CSS available to your Package's target by including CSS in your target's dependencies as follows:
```swift
targets: [
    .target(
        name: "TheNameOfYourTarget",
        dependencies: [
            .product(name: "CSS", package: "swift-css")
        ]
    )
]
```

## Contributing

We welcome contributions to swift-css! If you have an idea for a new feature or have found a bug, please open an issue. If you'd like to contribute code, please fork the repository and submit a pull request.

## License

This library is released under the APACHE license. See [LICENSE](LICENSE) for details.

