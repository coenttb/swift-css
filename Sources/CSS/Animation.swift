//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

import Foundation

// MARK: - Animation Properties

public struct Animation: Equatable {
    public var name: String
    public var duration: Time
    public var timingFunction: TimingFunction
    public var delay: Time
    public var iterationCount: IterationCount
    public var direction: Direction
    public var fillMode: FillMode
    public var playState: PlayState

    public init(
        name: String,
        duration: Time,
        timingFunction: TimingFunction = .ease,
        delay: Time = .seconds(0),
        iterationCount: IterationCount = .once,
        direction: Direction = .normal,
        fillMode: FillMode = .none,
        playState: PlayState = .running
    ) {
        self.name = name
        self.duration = duration
        self.timingFunction = timingFunction
        self.delay = delay
        self.iterationCount = iterationCount
        self.direction = direction
        self.fillMode = fillMode
        self.playState = playState
    }

    public enum TimingFunction: Equatable {
        case ease
        case linear
        case easeIn
        case easeOut
        case easeInOut
        case cubicBezier(x1: Double, y1: Double, x2: Double, y2: Double)
        case steps(Int, StepPosition)

        public enum StepPosition: String {
            case start, end
        }
    }

    public enum IterationCount: Equatable {
        case finite(Double)
        case infinite

        public static let once: Self = .finite(1)
    }

    public enum Direction: String {
        case normal, reverse, alternate, alternateReverse
    }

    public enum FillMode: String {
        case none, forwards, backwards, both
    }

    public enum PlayState: String {
        case running, paused
    }
}

// MARK: - Keyframes

public struct Keyframes {
    public var name: String
    public var frames: [KeyframeSelector: [Property]]

    public init(name: String, frames: [KeyframeSelector: [Property]]) {
        self.name = name
        self.frames = frames
    }

    public enum KeyframeSelector: Equatable, Hashable {
        case percentage(Double)
        case from
        case to

        public static func == (lhs: KeyframeSelector, rhs: KeyframeSelector) -> Bool {
            switch (lhs, rhs) {
            case (.percentage(let lhsValue), .percentage(let rhsValue)):
                return lhsValue == rhsValue
            case (.from, .from), (.to, .to):
                return true
            default:
                return false
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case .percentage(let value):
                hasher.combine(value)
            case .from:
                hasher.combine("from")
            case .to:
                hasher.combine("to")
            }
        }
    }

    public struct Property {
        public var name: String
        public var value: String

        public init(_ name: String, _ value: String) {
            self.name = name
            self.value = value
        }
    }
}

// MARK: - Time

public enum Time: Equatable {
    case seconds(Double)
    case milliseconds(Double)

    public static func + (lhs: Time, rhs: Time) -> Time {
        switch (lhs, rhs) {
        case (.seconds(let l), .seconds(let r)):
            return .seconds(l + r)
        case (.milliseconds(let l), .milliseconds(let r)):
            return .milliseconds(l + r)
        case (.seconds(let s), .milliseconds(let ms)):
            return .seconds(s + ms / 1000)
        case (.milliseconds(let ms), .seconds(let s)):
            return .seconds(s + ms / 1000)
        }
    }
}

// MARK: - CustomStringConvertible Conformances

extension Animation: CustomStringConvertible {
    public var description: String {
        [
            name,
            duration.description,
            timingFunction.description,
            delay.description,
            iterationCount.description,
            direction.rawValue,
            fillMode.rawValue,
            playState.rawValue
        ].joined(separator: " ")
    }
}

extension Animation.TimingFunction: CustomStringConvertible {
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
        case .cubicBezier(let x1, let y1, let x2, let y2):
            return "cubic-bezier(\(x1), \(y1), \(x2), \(y2))"
        case .steps(let count, let position):
            return "steps(\(count), \(position.rawValue))"
        }
    }
}

extension Animation.IterationCount: CustomStringConvertible {
    public var description: String {
        switch self {
        case .finite(let count):
            return String(count)
        case .infinite:
            return "infinite"
        }
    }
}

extension Time: CustomStringConvertible {
    public var description: String {
        switch self {
        case .seconds(let value):
            return "\(value)s"
        case .milliseconds(let value):
            return "\(value)ms"
        }
    }
}

extension Keyframes: CustomStringConvertible {
    public var description: String {
        var result = "@keyframes \(name) {\n"
        for (selector, properties) in frames {
            result += "  \(selector.description) {\n"
            for property in properties {
                result += "    \(property.name): \(property.value);\n"
            }
            result += "  }\n"
        }
        result += "}"
        return result
    }
}

extension Keyframes.KeyframeSelector: CustomStringConvertible {
    public var description: String {
        switch self {
        case .percentage(let value):
            return "\(value)%"
        case .from:
            return "from"
        case .to:
            return "to"
        }
    }
}

// MARK: - Convenience Extensions

extension Animation.TimingFunction {
    public static let easeInSine = Animation.TimingFunction.cubicBezier(x1: 0.12, y1: 0, x2: 0.39, y2: 0)
    public static let easeOutSine = Animation.TimingFunction.cubicBezier(x1: 0.61, y1: 1, x2: 0.88, y2: 1)
    public static let easeInOutSine = Animation.TimingFunction.cubicBezier(x1: 0.37, y1: 0, x2: 0.63, y2: 1)
}

