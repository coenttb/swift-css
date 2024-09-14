//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 01/09/2024.
//

import Foundation

public struct Font: Sendable, Equatable {
    public var family: [String]
    public var size: CSS.Font.Size
    public var weight: CSS.Font.Weight
    public var style: CSS.Font.Style
    public var variant: Font.Variant
    public var lineHeight: CSS.LineHeight?
    public var stretch: CSS.Font.Stretch
    
    public init(
        family: [String] = ["system-ui"],
        size: CSS.Font.Size = .medium,
        weight: CSS.Font.Weight = .normal,
        style: CSS.Font.Style = .normal,
        variant: Font.Variant = .normal,
        lineHeight: LineHeight? = nil,
        stretch: CSS.Font.Stretch = .normal
    ) {
        self.family = family
        self.size = size
        self.weight = weight
        self.style = style
        self.variant = variant
        self.lineHeight = lineHeight
        self.stretch = stretch
    }
    
    public enum Size: Sendable, Equatable {
        case length(CSS.Length?)
        case keyword(CSS.Font.Size.Keyword?)
        
        
        public enum Keyword: String, Sendable {
            case xxSmall = "xx-small"
            case xSmall = "x-small"
            case small, medium, large
            case xLarge = "x-large"
            case xxLarge = "xx-large"
            case xxxLarge = "xxx-large"
            case smaller, larger
        }
        
        public static let xxSmall: CSS.Font.Size = .keyword(.xxSmall)
        public static let xSmall: CSS.Font.Size = .keyword(.xSmall)
        public static let small: CSS.Font.Size = .keyword(.small)
        public static let medium: CSS.Font.Size = .keyword(.medium)
        public static let large: CSS.Font.Size = .keyword(.large)
        public static let xLarge: CSS.Font.Size = .keyword(.xLarge)
        public static let xxLarge: CSS.Font.Size = .keyword(.xxLarge)
        public static let xxxLarge: CSS.Font.Size = .keyword(.xxxLarge)
        public static let smaller: CSS.Font.Size = .keyword(.smaller)
        public static let larger: CSS.Font.Size = .keyword(.larger)
    }
    
    
    public enum Style: String, Sendable {
        case normal, italic, oblique
    }
    
    public enum Variant: String, Sendable {
        case normal, smallCaps = "small-caps"
    }
    
    public enum Stretch: String, Sendable {
        case ultraCondensed = "ultra-condensed"
        case extraCondensed = "extra-condensed"
        case condensed
        case semiCondensed = "semi-condensed"
        case normal
        case semiExpanded = "semi-expanded"
        case expanded
        case extraExpanded = "extra-expanded"
        case ultraExpanded = "ultra-expanded"
    }
}

extension CSS.Font {
    public static func system(size: CSS.Font.Size) -> Font {
        Font(family: ["system-ui"], size: size)
    }
    
    public static func custom(_ name: String, size: CSS.Font.Size) -> Font {
        Font(family: [name], size: size)
    }
}

extension CSS.Font.Size {
    public var description: String {
        switch self {
        case .length(let length):
            return length?.description ?? ""
        case .keyword(let keyword):
            return keyword?.rawValue ?? ""
        }
    }
}




//
//public protocol CSS.Font.SizeExpressible {
//    var fontSize: Font.CSS.Font.Size { get }
//}
//
//extension Font.CSS.Font.Size: CSS.Font.SizeExpressible {
//    public var fontSize: Font.CSS.Font.Size { self }
//}
//
//extension Length: CSS.Font.SizeExpressible {
//    public var fontSize: Font.CSS.Font.Size { .length(self) }
//}
//
//
//
//extension Font {
//    public init(
//        family: [String] = ["system-ui"],
//        size: CSS.Font.SizeExpressible = Font.CSS.Font.Size.medium,
//        weight: CSS.Font.Weight = .normal,
//        style: CSS.Font.Style = .normal,
//        variant: Font.Variant = .normal,
//        lineHeight: LineHeightExpressible? = nil,
//        stretch: CSS.Font.Stretch = .normal
//    ) {
//        self.family = family
//        self.size = size.fontSize
//        self.weight = weight
//        self.style = style
//        self.variant = variant
//        self.lineHeight = lineHeight?.lineHeight ?? nil
//        self.stretch = stretch
//    }
//}
