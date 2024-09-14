//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public enum GridTemplateColumns {
    case none
    case lengths([Length])
    case tracks([GridTrack])
    case `repeat`(RepeatValue, [GridTrack])
    case custom(String)
    
    public enum RepeatValue {
        case count(Int)
        case autoFill
        case autoFit
    }
}

public enum GridTemplateRows {
    case none
    case lengths([Length])
    case tracks([GridTrack])
    case `repeat`(GridTemplateColumns.RepeatValue, [GridTrack])
    case custom(String)
}

public enum GridTrack {
    case fr(Double)
    case minmax(Length, Length)
    case auto
    case length(Length)
    case fitContent(Length)
}

public enum GridTemplateAreas {
    case none
    case areas([[String?]])
    case custom(String)
}

public enum GridAutoColumns {
    case auto
    case length(Length)
    case minmax(Length, Length)
    case fitContent(Length)
}

public enum GridAutoRows {
    case auto
    case length(Length)
    case minmax(Length, Length)
    case fitContent(Length)
}

public enum GridAutoFlow: String {
    case row
    case column
    case rowDense = "row dense"
    case columnDense = "column dense"
}

public struct GridGap {
    public var rowGap: Length
    public var columnGap: Length
    
    public init(row: Length, column: Length) {
        self.rowGap = row
        self.columnGap = column
    }
    
    public init(_ gap: Length) {
        self.rowGap = gap
        self.columnGap = gap
    }
}

// MARK: - Grid Item Properties

public enum GridColumnStart {
    case auto
    case span(Int)
    case line(Int)
    case name(String)
}

public enum GridColumnEnd {
    case auto
    case span(Int)
    case line(Int)
    case name(String)
}

public enum GridRowStart {
    case auto
    case span(Int)
    case line(Int)
    case name(String)
}

public enum GridRowEnd {
    case auto
    case span(Int)
    case line(Int)
    case name(String)
}

public enum GridArea {
    case auto
    case custom(String)
    case area(rowStart: Int, columnStart: Int, rowEnd: Int, columnEnd: Int)
    case named(String)
}

// MARK: - Convenience Aliases

public typealias GridColumn = (start: GridColumnStart, end: GridColumnEnd)
public typealias GridRow = (start: GridRowStart, end: GridRowEnd)

// MARK: - Grid Container

public struct GridContainer {
    public var templateColumns: GridTemplateColumns?
    public var templateRows: GridTemplateRows?
    public var templateAreas: GridTemplateAreas?
    public var autoColumns: GridAutoColumns?
    public var autoRows: GridAutoRows?
    public var autoFlow: GridAutoFlow?
    public var gap: GridGap?
    
    public init(
        templateColumns: GridTemplateColumns? = nil,
        templateRows: GridTemplateRows? = nil,
        templateAreas: GridTemplateAreas? = nil,
        autoColumns: GridAutoColumns? = nil,
        autoRows: GridAutoRows? = nil,
        autoFlow: GridAutoFlow? = nil,
        gap: GridGap? = nil
    ) {
        self.templateColumns = templateColumns
        self.templateRows = templateRows
        self.templateAreas = templateAreas
        self.autoColumns = autoColumns
        self.autoRows = autoRows
        self.autoFlow = autoFlow
        self.gap = gap
    }
}

// MARK: - Grid Item

public struct GridItem {
    public var columnStart: GridColumnStart?
    public var columnEnd: GridColumnEnd?
    public var rowStart: GridRowStart?
    public var rowEnd: GridRowEnd?
    public var area: GridArea?
    
    public init(
        columnStart: GridColumnStart? = nil,
        columnEnd: GridColumnEnd? = nil,
        rowStart: GridRowStart? = nil,
        rowEnd: GridRowEnd? = nil,
        area: GridArea? = nil
    ) {
        self.columnStart = columnStart
        self.columnEnd = columnEnd
        self.rowStart = rowStart
        self.rowEnd = rowEnd
        self.area = area
    }
}

// MARK: - CustomStringConvertible Conformances

extension GridTemplateColumns: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "none"
        case .lengths(let lengths):
            return lengths.map { $0.description }.joined(separator: " ")
        case .tracks(let tracks):
            return tracks.map { $0.description }.joined(separator: " ")
        case .repeat(let value, let tracks):
            let tracksString = tracks.map { $0.description }.joined(separator: " ")
            switch value {
            case .count(let count):
                return "repeat(\(count), \(tracksString))"
            case .autoFill:
                return "repeat(auto-fill, \(tracksString))"
            case .autoFit:
                return "repeat(auto-fit, \(tracksString))"
            }
        case .custom(let value):
            return value
        }
    }
}

extension GridTemplateRows: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "none"
        case .lengths(let lengths):
            return lengths.map { $0.description }.joined(separator: " ")
        case .tracks(let tracks):
            return tracks.map { $0.description }.joined(separator: " ")
        case .repeat(let value, let tracks):
            let tracksString = tracks.map { $0.description }.joined(separator: " ")
            switch value {
            case .count(let count):
                return "repeat(\(count), \(tracksString))"
            case .autoFill:
                return "repeat(auto-fill, \(tracksString))"
            case .autoFit:
                return "repeat(auto-fit, \(tracksString))"
            }
        case .custom(let value):
            return value
        }
    }
}

extension GridTrack: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fr(let value):
            return "\(value)fr"
        case .minmax(let min, let max):
            return "minmax(\(min), \(max))"
        case .auto:
            return "auto"
        case .length(let length):
            return length.description
        case .fitContent(let length):
            return "fit-content(\(length))"
        }
    }
}

extension GridTemplateAreas: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "none"
        case .areas(let areas):
            return areas.map { row in
                "'" + row.map { $0 ?? "." }.joined(separator: " ") + "'"
            }.joined(separator: " ")
        case .custom(let value):
            return value
        }
    }
}

extension GridAutoColumns: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .length(let length):
            return length.description
        case .minmax(let min, let max):
            return "minmax(\(min), \(max))"
        case .fitContent(let length):
            return "fit-content(\(length))"
        }
    }
}

extension GridAutoRows: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .length(let length):
            return length.description
        case .minmax(let min, let max):
            return "minmax(\(min), \(max))"
        case .fitContent(let length):
            return "fit-content(\(length))"
        }
    }
}

extension GridGap: CustomStringConvertible {
    public var description: String {
        if rowGap == columnGap {
            return rowGap.description
        } else {
            return "\(rowGap) \(columnGap)"
        }
    }
}

extension GridColumnStart: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .span(let value):
            return "span \(value)"
        case .line(let value):
            return String(value)
        case .name(let value):
            return value
        }
    }
}

extension GridColumnEnd: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .span(let value):
            return "span \(value)"
        case .line(let value):
            return String(value)
        case .name(let value):
            return value
        }
    }
}

extension GridRowStart: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .span(let value):
            return "span \(value)"
        case .line(let value):
            return String(value)
        case .name(let value):
            return value
        }
    }
}

extension GridRowEnd: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .span(let value):
            return "span \(value)"
        case .line(let value):
            return String(value)
        case .name(let value):
            return value
        }
    }
}

extension GridArea: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            return "auto"
        case .custom(let value):
            return value
        case .area(let rowStart, let columnStart, let rowEnd, let columnEnd):
            return "\(rowStart) / \(columnStart) / \(rowEnd) / \(columnEnd)"
        case .named(let value):
            return value
        }
    }
}
