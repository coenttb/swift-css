//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public enum ZIndex: Sendable, Equatable {
    case auto
    case index(Int)
    case global(Global)

    public enum Global: String, Sendable {
        case inherit
        case initial
        case revert
        case revertLayer = "revert-layer"
        case unset
    }
}

// Convenience static properties
extension ZIndex {
    public static let inherit: Self = .global(.inherit)
    public static let initial: Self = .global(.initial)
    public static let revert: Self = .global(.revert)
    public static let revertLayer: Self = .global(.revertLayer)
    public static let unset: Self = .global(.unset)
}

// ExpressibleByIntegerLiteral conformance
extension ZIndex: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .index(value)
    }
}

// CustomStringConvertible conformance
extension ZIndex: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .index(let value):
            return String(value)
        case .global(let global):
            return global.rawValue
        }
    }
}
