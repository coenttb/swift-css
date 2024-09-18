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
            let cleanedValue = value.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
            return "#\(cleanedValue)"
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


extension CSS.Color {
    public func adjustBrightness(by percentage: Double) -> CSS.Color {
        guard percentage >= -1, percentage <= 1 else { return self }
        
        func adjustComponent(_ value: Int) -> Int {
            if percentage > 0 {
                return min(255, max(0, Int(Double(value) + (255 - Double(value)) * percentage)))
            } else {
                return max(0, min(255, Int(Double(value) * (1 + percentage))))
            }
        }
        
        func adjustLightness(_ l: Double) -> Double {
            if percentage > 0 {
                return min(100, max(0, l + (100 - l) * percentage))
            } else {
                return max(0, min(100, l * (1 + percentage)))
            }
        }
        
        switch self {
        case .rgb(let r, let g, let b):
            return .rgb(red: adjustComponent(r), green: adjustComponent(g), blue: adjustComponent(b))
            
        case .rgba(let r, let g, let b, let a):
            return .rgba(red: adjustComponent(r), green: adjustComponent(g), blue: adjustComponent(b), alpha: a)
            
        case .hsl(let h, let s, let l):
            return .hsl(hue: h, saturation: s, lightness: adjustLightness(l))
            
        case .hsla(let h, let s, let l, let a):
            return .hsla(hue: h, saturation: s, lightness: adjustLightness(l), alpha: a)
            
        case .hex(let value):
            let rgb = hexToRGB(value)
            let adjustedRGB = rgb.map(adjustComponent)
            return .hex(rgbToHex(adjustedRGB))
            
        default:
            return self
        }
    }
    
    private func hexToRGB(_ hex: String) -> [Int] {
        var hexColor = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        if hexColor.count == 3 {
            hexColor = hexColor.map { "\($0)\($0)" }.joined()
        }
        guard hexColor.count == 6 else { return [] }
        
        return stride(from: 0, to: 6, by: 2).compactMap { i in
            let start = hexColor.index(hexColor.startIndex, offsetBy: i)
            let end = hexColor.index(start, offsetBy: 2)
            let hexPair = String(hexColor[start..<end])
            return Int(hexPair, radix: 16)
        }
    }
    
    private func rgbToHex(_ rgb: [Int]) -> String {
        String(format: "#%02X%02X%02X", rgb[0], rgb[1], rgb[2])
    }
}


extension CSS.Color {
    public func darker(by percentage: Double = 0.2) -> CSS.Color {
        adjustBrightness(by: -percentage)
    }
    
    public func lighter(by percentage: Double = 0.2) -> CSS.Color {
        adjustBrightness(by: percentage)
    }
}
