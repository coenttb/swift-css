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
import CSS

let backgroundColor: CSS.Color = .rgba(red: 100, green: 149, blue: 237, alpha: 1) // Outputs: rgb(100, 149, 237)
let fontSize: Length = 24.px // Outputs: 24px
```

## Recommended usage [swift-html](https://github.com/coenttb/swift-html)

`swift-css` serves as the foundation for building your own styling functionality. For instance, [swift-html](https://github.com/coenttb/swift-html) leverages `swift-css` to safely and effortlessly apply inline styles to HTML elements. Here's an example of swift-html's use of swift-css:

```swift
import HTML

let document = HTMLPreview.modern {
  h1 { "Type-safe HTML" }
    .color(.blue)
    .fontSize(24.px)
  p { "With type-safe CSS!" }
    .margin(top: 10.px, bottom: 10.px)
}
```
The .color and .fontSize methods leverage the CSS Domain Model to ensure type-safe styling. Working with type-safe CSS makes web development a truly enjoyable experience.

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

