//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 01/09/2024.
//

import Foundation

public struct Font: Sendable, Equatable {
    public var family: [String]
    public var size: FontSize
    public var weight: FontWeight
    public var style: FontStyle
    public var variant: FontVariant
    public var lineHeight: LineHeight?
    public var stretch: FontStretch
    
    public init(
        family: [String] = ["system-ui"],
        size: FontSize = .medium,
        weight: FontWeight = .normal,
        style: FontStyle = .normal,
        variant: FontVariant = .normal,
        lineHeight: LineHeight? = nil,
        stretch: FontStretch = .normal
    ) {
        self.family = family
        self.size = size
        self.weight = weight
        self.style = style
        self.variant = variant
        self.lineHeight = lineHeight
        self.stretch = stretch
    }
    
    public enum FontSize: Sendable, Equatable {
        case length(Length?)
        case keyword(FontSizeKeyword?)
        
        
        public enum FontSizeKeyword: String, Sendable {
            case xxSmall = "xx-small"
            case xSmall = "x-small"
            case small, medium, large
            case xLarge = "x-large"
            case xxLarge = "xx-large"
            case xxxLarge = "xxx-large"
            case smaller, larger
        }
        
        public static let xxSmall: FontSize = .keyword(.xxSmall)
        public static let xSmall: FontSize = .keyword(.xSmall)
        public static let small: FontSize = .keyword(.small)
        public static let medium: FontSize = .keyword(.medium)
        public static let large: FontSize = .keyword(.large)
        public static let xLarge: FontSize = .keyword(.xLarge)
        public static let xxLarge: FontSize = .keyword(.xxLarge)
        public static let xxxLarge: FontSize = .keyword(.xxxLarge)
        public static let smaller: FontSize = .keyword(.smaller)
        public static let larger: FontSize = .keyword(.larger)
    }
    
    public enum FontWeight: Sendable, Equatable, ExpressibleByIntegerLiteral {
        case keyword(FontWeightKeyword)
        case number(Int)
        
        public init(integerLiteral value: Int) {
            self = .number(value)
        }
        
        public enum FontWeightKeyword: String, Sendable {
            case normal, bold, lighter, bolder
        }
        
        public static let normal: FontWeight = .keyword(.normal)
        public static let bold: FontWeight = .keyword(.bold)
        public static let lighter: FontWeight = .keyword(.lighter)
        public static let bolder: FontWeight = .keyword(.bolder)
        
        public static let thin: FontWeight = .number(100)
        public static let extraLight: FontWeight = .number(200)
        public static let light: FontWeight = .number(300)
        public static let regular: FontWeight = .number(400)
        public static let medium: FontWeight = .number(500)
        public static let semiBold: FontWeight = .number(600)
        public static let extraBold: FontWeight = .number(800)
        public static let black: FontWeight = .number(900)
    }
    
    public enum FontStyle: String, Sendable {
        case normal, italic, oblique
    }
    
    public enum FontVariant: String, Sendable {
        case normal, smallCaps = "small-caps"
    }
    
    public enum FontStretch: String, Sendable {
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

extension Font {
    public static func system(size: FontSize) -> Font {
        Font(family: ["system-ui"], size: size)
    }
    
    public static func custom(_ name: String, size: FontSize) -> Font {
        Font(family: [name], size: size)
    }
}

extension Font.FontSize {
    public var description: String {
        switch self {
        case .length(let length):
            return length?.description ?? ""
        case .keyword(let keyword):
            return keyword?.rawValue ?? ""
        }
    }
}

extension Font.FontWeight {
    public var description: String {
        switch self {
        case .keyword(let keyword):
            return keyword.rawValue
        case .number(let number):
            return String(number)
        }
    }
}



public protocol FontSizeExpressible {
    var fontSize: Font.FontSize { get }
}

extension Font.FontSize: FontSizeExpressible {
    public var fontSize: Font.FontSize { self }
}

extension Length: FontSizeExpressible {
    public var fontSize: Font.FontSize { .length(self) }
}



extension Font {
    public init(
        family: [String] = ["system-ui"],
        size: FontSizeExpressible = Font.FontSize.medium,
        weight: FontWeight = .normal,
        style: FontStyle = .normal,
        variant: FontVariant = .normal,
        lineHeight: LineHeightExpressible? = nil,
        stretch: FontStretch = .normal
    ) {
        self.family = family
        self.size = size.fontSize
        self.weight = weight
        self.style = style
        self.variant = variant
        self.lineHeight = lineHeight?.lineHeight ?? nil
        self.stretch = stretch
    }
}
