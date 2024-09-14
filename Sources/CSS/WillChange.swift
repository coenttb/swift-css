//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public struct WillChange: Equatable {
    public var properties: [Property]
    
    public init(_ properties: Property...) {
        self.properties = properties
    }
    
    public enum Property: Equatable {
        case auto
        case scrollPosition
        case contents
        case custom(String)
        
        public var description: String {
            switch self {
            case .auto:
                return "auto"
            case .scrollPosition:
                return "scroll-position"
            case .contents:
                return "contents"
            case .custom(let value):
                return value
            }
        }
    }
}

// MARK: - CustomStringConvertible Conformance

extension WillChange: CustomStringConvertible {
    public var description: String {
        properties.map { $0.description }.joined(separator: ", ")
    }
}
