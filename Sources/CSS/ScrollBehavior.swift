//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation


import Foundation

public enum ScrollBehavior: Equatable {
    case auto
    case smooth
    case custom(String)
}


// MARK: - CustomStringConvertible Conformance

extension ScrollBehavior: CustomStringConvertible, ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .custom(value)
    }
    
    public var description: String {
        switch self {
        case .auto: return "auto"
        case .smooth: return "smooth"
        case .custom(let value):
            return value
        }
    }
}
