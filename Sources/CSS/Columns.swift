//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

// MARK: - ColumnCount

public enum ColumnCount: Equatable {
    case auto
    case count(Int)
    
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .count(let value):
            return String(value)
        }
    }
}

// MARK: - ColumnGap

public enum ColumnGap: Equatable {
    case normal
    case length(Length)
    
    public var description: String {
        switch self {
        case .normal:
            return "normal"
        case .length(let length):
            return length.description
        }
    }
}

// MARK: - Columns

public struct Columns: Equatable {
    public var count: ColumnCount?
    public var gap: ColumnGap?
    
    public init(count: ColumnCount? = nil, gap: ColumnGap? = nil) {
        self.count = count
        self.gap = gap
    }
}



// MARK: - Convenience Extensions

extension Columns {
    public static func count(_ count: ColumnCount) -> Columns {
        Columns(count: count)
    }
    
    public static func gap(_ gap: ColumnGap) -> Columns {
        Columns(gap: gap)
    }
    
    public static func count(_ count: ColumnCount, gap: ColumnGap) -> Columns {
        Columns(count: count, gap: gap)
    }
}
