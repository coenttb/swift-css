//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public struct BoxShadow: Equatable {
    public var shadows: [Shadow]
    
    public init(_ shadows: Shadow...) {
        self.shadows = shadows
    }
    
    public struct Shadow: Equatable {
        public var offsetX: Length
        public var offsetY: Length
        public var blurRadius: Length
        public var spreadRadius: Length
        public var color: Color
        public var isInset: Bool
        
        public init(
            offsetX: Length = .px(0),
            offsetY: Length = .px(0),
            blurRadius: Length = .px(0),
            spreadRadius: Length = .px(0),
            color: Color,
            isInset: Bool = false
        ) {
            self.offsetX = offsetX
            self.offsetY = offsetY
            self.blurRadius = blurRadius
            self.spreadRadius = spreadRadius
            self.color = color
            self.isInset = isInset
        }
    }
}

extension BoxShadow: CustomStringConvertible {
    public var description: String {
        shadows.map { $0.description }.joined(separator: ", ")
    }
}

extension BoxShadow.Shadow: CustomStringConvertible {
    public var description: String {
        let insetPrefix = isInset ? "inset " : ""
        return "\(insetPrefix)\(offsetX) \(offsetY) \(blurRadius) \(spreadRadius) \(color.description)"
    }
}

// Convenience methods for common shadow styles
extension BoxShadow {
    public static func simple(
        offsetX: Length = .px(0),
        offsetY: Length = .px(4),
        blurRadius: Length = .px(6),
        color: Color
    ) -> BoxShadow {
        BoxShadow(Shadow(offsetX: offsetX, offsetY: offsetY, blurRadius: blurRadius, color: color))
    }
    
    public static func layered(
        light: Color,
        medium: Color,
        dark: Color
    ) -> BoxShadow {
        BoxShadow(
            Shadow(offsetY: .px(2), blurRadius: .px(4), color: light),
            Shadow(offsetY: .px(4), blurRadius: .px(8), color: medium),
            Shadow(offsetY: .px(8), blurRadius: .px(16), color: dark)
        )
    }
    
    public static func inset(
        offsetX: Length = .px(0),
        offsetY: Length = .px(2),
        blurRadius: Length = .px(4),
        spreadRadius: Length = .px(-1),
        color: Color
    ) -> BoxShadow {
        BoxShadow(Shadow(offsetX: offsetX, offsetY: offsetY, blurRadius: blurRadius, spreadRadius: spreadRadius, color: color, isInset: true))
    }
}

