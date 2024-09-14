//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//


import Foundation

public struct Outline: Equatable {
    public var style: Style
    public var width: Width
    public var color: CSS.Color?
    
    public init(style: Style = .none, width: Width = .medium, color: CSS.Color? = nil) {
        self.style = style
        self.width = width
        self.color = color
    }
    
    public enum Style: String, Equatable {
        case none, hidden, dotted, dashed, solid, double, groove, ridge, inset, outset
    }
    
    public enum Width: Equatable {
        case thin
        case medium
        case thick
        case length(Length)
        
        public var description: String {
            switch self {
            case .thin, .medium, .thick:
                return rawValue
            case .length(let length):
                return length.description
            }
        }
    }
}

extension Outline: CustomStringConvertible {
    public var description: String {
        var parts: [String] = []
        parts.append(style.rawValue)
        parts.append(width.description)
        if let color = color {
            parts.append(color.description)
        }
        return parts.joined(separator: " ")
    }
}

extension Outline.Width {
    fileprivate var rawValue: String {
        switch self {
        case .thin: return "thin"
        case .medium: return "medium"
        case .thick: return "thick"
        case .length: return ""
        }
    }
}


// Convenience initializers and static properties
extension Outline {
    public static let none = Outline(style: .none)
    public static let solid = Outline(style: .solid)
    public static let dashed = Outline(style: .dashed)
    public static let dotted = Outline(style: .dotted)
    
    public static func solid(width: Width = .medium, color: CSS.Color? = nil) -> Outline {
        Outline(style: .solid, width: width, color: color)
    }
    
    public static func dashed(width: Width = .medium, color: CSS.Color? = nil) -> Outline {
        Outline(style: .dashed, width: width, color: color)
    }
    
    public static func dotted(width: Width = .medium, color: CSS.Color? = nil) -> Outline {
        Outline(style: .dotted, width: width, color: color)
    }
}
