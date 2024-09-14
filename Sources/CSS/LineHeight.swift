//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 07/09/2024.
//

import Foundation

public enum LineHeight: Sendable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    public init(floatLiteral value: Double) {
        self = .number(value)
    }
    
    public init(integerLiteral value: Int) {
        self = .number(Double(value))
    }
    case normal
    case number(Double?)
    case length(Length?)
    case percentage(Double?)
}

extension LineHeight: CustomStringConvertible {
    public var description: String {
        switch self {
        case .normal:
            return "normal"
        case .number(let number):
            return number.map { "\($0)" } ?? ""
        case .length(let length):
            return length?.description ?? ""
        case .percentage(let percentage):
            return percentage.map { "\($0)%" } ?? ""
        }
    }
}


public protocol LineHeightExpressible {
    var lineHeight: LineHeight { get }
}

extension LineHeight: LineHeightExpressible {
    public var lineHeight: LineHeight { self }
}

extension Length: LineHeightExpressible {
    public var lineHeight: LineHeight { .length(self) }
}


