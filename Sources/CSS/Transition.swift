//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public struct Transition: Sendable, Equatable {
    public var property: Property
    public var duration: Time
    public var timingFunction: TimingFunction
    public var delay: Time?

    public init(
        property: Property,
        duration: Time,
        timingFunction: TimingFunction = .ease,
        delay: Time? = nil
    ) {
        self.property = property
        self.duration = duration
        self.timingFunction = timingFunction
        self.delay = delay
    }

    public enum Property: Sendable, Equatable {
        case all
        case none
        case custom(String)
    }

    public struct Time: Sendable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
        public var value: Double
        public var unit: Unit

        public enum Unit: String, Sendable {
            case seconds = "s"
            case milliseconds = "ms"
        }

        public init(_ value: Double, _ unit: Unit) {
            self.value = value
            self.unit = unit
        }

        public init(floatLiteral value: Double) {
            self.init(value, .seconds)
        }
        
        public init(integerLiteral value: Int) {
            self.init(Double(value), .seconds)
        }
    }

    public enum TimingFunction: Sendable, Equatable {
        case ease
        case linear
        case easeIn
        case easeOut
        case easeInOut
        case stepStart
        case stepEnd
        case cubicBezier(x1: Double, y1: Double, x2: Double, y2: Double)
    }
}

extension Transition: CustomStringConvertible {
    public var description: String {
        var parts = [property.description, duration.description, timingFunction.description]
        if let delay = delay {
            parts.append(delay.description)
        }
        return parts.joined(separator: " ")
    }
}

extension Transition.Property: CustomStringConvertible {
    public var description: String {
        switch self {
        case .all:
            return "all"
        case .none:
            return "none"
        case .custom(let prop):
            return prop
        }
    }
}

extension Transition.Time: CustomStringConvertible {
    public var description: String {
        return "\(value)\(unit.rawValue)"
    }
}

extension Transition.TimingFunction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ease:
            return "ease"
        case .linear:
            return "linear"
        case .easeIn:
            return "ease-in"
        case .easeOut:
            return "ease-out"
        case .easeInOut:
            return "ease-in-out"
        case .stepStart:
            return "step-start"
        case .stepEnd:
            return "step-end"
        case .cubicBezier(let x1, let y1, let x2, let y2):
            return "cubic-bezier(\(x1), \(y1), \(x2), \(y2))"
        }
    }
}


extension Transition {
    public static func all(duration: Time, timingFunction: TimingFunction = .ease, delay: Time? = nil) -> Self {
        Transition(property: .all, duration: duration, timingFunction: timingFunction, delay: delay)
    }

    public static func none() -> Self {
        Transition(property: .none, duration: 0)
    }

    public static func custom(_ property: String, duration: Time, timingFunction: TimingFunction = .ease, delay: Time? = nil) -> Self {
        Transition(property: .custom(property), duration: duration, timingFunction: timingFunction, delay: delay)
    }
}

extension Transition.TimingFunction {
    public static let easeInSine = Transition.TimingFunction.cubicBezier(x1: 0.12, y1: 0, x2: 0.39, y2: 0)
    public static let easeOutSine = Transition.TimingFunction.cubicBezier(x1: 0.61, y1: 1, x2: 0.88, y2: 1)
    public static let easeInOutSine = Transition.TimingFunction.cubicBezier(x1: 0.37, y1: 0, x2: 0.63, y2: 1)
}
