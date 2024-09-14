//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public struct Filter: Equatable {
    public var filters: [FilterFunction]
    
    public init(_ filters: [FilterFunction]) {
        self.filters = filters
    }
    
    public init(_ filters: FilterFunction...) {
        self.filters = filters
    }
    
    public enum FilterFunction: Equatable {
        case blur(Length)
        case brightness(Double)
        case contrast(Double)
        case dropShadow(offsetX: Length, offsetY: Length, blurRadius: Length, color: CSS.Color)
        case grayscale(Double)
        case hueRotate(Angle)
        case invert(Double)
        case opacity(Double)
        case saturate(Double)
        case sepia(Double)
        case url(String)
    }
}

extension Filter: CustomStringConvertible {
    public var description: String {
        filters.map { $0.description }.joined(separator: " ")
    }
}

extension Filter.FilterFunction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .blur(let radius):
            return "blur(\(radius))"
        case .brightness(let amount):
            return "brightness(\(formatPercentage(amount)))"
        case .contrast(let amount):
            return "contrast(\(formatPercentage(amount)))"
        case .dropShadow(let offsetX, let offsetY, let blurRadius, let color):
            return "drop-shadow(\(offsetX) \(offsetY) \(blurRadius) \(color.description))"
        case .grayscale(let amount):
            return "grayscale(\(formatPercentage(amount)))"
        case .hueRotate(let angle):
            return "hue-rotate(\(angle))"
        case .invert(let amount):
            return "invert(\(formatPercentage(amount)))"
        case .opacity(let amount):
            return "opacity(\(formatPercentage(amount)))"
        case .saturate(let amount):
            return "saturate(\(formatPercentage(amount)))"
        case .sepia(let amount):
            return "sepia(\(formatPercentage(amount)))"
        case .url(let value):
            return "url(\(value))"
        }
    }
    
    private func formatPercentage(_ value: Double) -> String {
        return String(format: "%.2f%%", value * 100)
    }
}

// Convenience methods for common filter styles
extension Filter {
    public static func blur(_ radius: Length) -> Filter {
        Filter(.blur(radius))
    }
    
    public static func brightness(_ amount: Double) -> Filter {
        Filter(.brightness(amount))
    }
    
    public static func contrast(_ amount: Double) -> Filter {
        Filter(.contrast(amount))
    }
    
    public static func dropShadow(offsetX: Length, offsetY: Length, blurRadius: Length, color: CSS.Color) -> Filter {
        Filter(.dropShadow(offsetX: offsetX, offsetY: offsetY, blurRadius: blurRadius, color: color))
    }
    
    public static func grayscale(_ amount: Double) -> Filter {
        Filter(.grayscale(amount))
    }
    
    public static func hueRotate(_ angle: Angle) -> Filter {
        Filter(.hueRotate(angle))
    }
    
    public static func invert(_ amount: Double) -> Filter {
        Filter(.invert(amount))
    }
    
    public static func opacity(_ amount: Double) -> Filter {
        Filter(.opacity(amount))
    }
    
    public static func saturate(_ amount: Double) -> Filter {
        Filter(.saturate(amount))
    }
    
    public static func sepia(_ amount: Double) -> Filter {
        Filter(.sepia(amount))
    }
}
