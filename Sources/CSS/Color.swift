//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public enum Color: Sendable, Equatable {
    case keyword(Keyword)
    case hex(String)
    case rgb(red: Int, green: Int, blue: Int)
    case rgba(red: Int, green: Int, blue: Int, alpha: Double)
    case hsl(hue: Int, saturation: Double, lightness: Double)
    case hsla(hue: Int, saturation: Double, lightness: Double, alpha: Double)
    case hwb(hue: Int, whiteness: Double, blackness: Double)
    case lab(lightness: Double, a: Double, b: Double)
    case lch(lightness: Double, chroma: Double, hue: Double)
    case system(SystemColor)
    case currentColor
    case transparent
    case global(Global)

    public enum Keyword: String, Sendable, CaseIterable {
        case black, silver, gray, white, maroon, red, purple, fuchsia, green, lime, olive, yellow, navy, blue, teal, aqua
        // Add more named colors as needed
    }

    public enum SystemColor: String, Sendable, CaseIterable {
        case canvasText = "CanvasText"
        case canvas = "Canvas"
        case linkText = "LinkText"
        case visitedText = "VisitedText"
        case activeText = "ActiveText"
        case buttonFace = "ButtonFace"
        case buttonText = "ButtonText"
        case buttonBorder = "ButtonBorder"
        case field = "Field"
        case fieldText = "FieldText"
        case highlight = "Highlight"
        case highlightText = "HighlightText"
        case selectedItem = "SelectedItem"
        case selectedItemText = "SelectedItemText"
        case mark = "Mark"
        case markText = "MarkText"
        // Add more system colors as needed
    }

    public enum Global: String, Sendable, CaseIterable {
        case inherit, initial, revert
        case revertLayer = "revert-layer"
        case unset
    }
}

extension Color: CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyword(let keyword):
            return keyword.rawValue
        case .hex(let value):
            return "#\(value)"
        case .rgb(let r, let g, let b):
            return "rgb(\(r), \(g), \(b))"
        case .rgba(let r, let g, let b, let a):
            return "rgba(\(r), \(g), \(b), \(a))"
        case .hsl(let h, let s, let l):
            return "hsl(\(h), \(s)%, \(l)%)"
        case .hsla(let h, let s, let l, let a):
            return "hsla(\(h), \(s)%, \(l)%, \(a))"
        case .hwb(let h, let w, let b):
            return "hwb(\(h) \(w)% \(b)%)"
        case .lab(let l, let a, let b):
            return "lab(\(l)% \(a) \(b))"
        case .lch(let l, let c, let h):
            return "lch(\(l)% \(c) \(h))"
        case .system(let color):
            return color.rawValue
        case .currentColor:
            return "currentColor"
        case .transparent:
            return "transparent"
        case .global(let value):
            return value.rawValue
        }
    }
}

// Convenience initializers and static properties
extension CSS.Color {
//    public static func hex(_ value: String) -> Self {
//        .hex(value.hasPrefix("#") ? String(value.dropFirst()) : value)
//    }
    
    
    public static let inherit: Self = .global(.inherit)
    public static let initial: Self = .global(.initial)
    public static let revert: Self = .global(.revert)
    public static let revertLayer: Self = .global(.revertLayer)
    public static let unset: Self = .global(.unset)
}
