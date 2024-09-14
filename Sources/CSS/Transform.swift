//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2024.
//

import Foundation

public enum Transform: Sendable, Equatable {
    case none
    case matrix(a: Double, b: Double, c: Double, d: Double, tx: Double, ty: Double)
    case matrix3d([Double]) // 16 values
    case translate(x: Length, y: Length?)
    case translate3d(x: Length, y: Length, z: Length)
    case translateX(Length)
    case translateY(Length)
    case translateZ(Length)
    case scale(x: Double, y: Double?)
    case scale3d(x: Double, y: Double, z: Double)
    case scaleX(Double)
    case scaleY(Double)
    case scaleZ(Double)
    case rotate(Angle)
    case rotate3d(x: Double, y: Double, z: Double, angle: Angle)
    case rotateX(Angle)
    case rotateY(Angle)
    case rotateZ(Angle)
    case skew(x: Angle, y: Angle?)
    case skewX(Angle)
    case skewY(Angle)
    case perspective(Length)
    case compound([Transform])
}

extension Transform: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "none"
        case let .matrix(a, b, c, d, tx, ty):
            return "matrix(\(a), \(b), \(c), \(d), \(tx), \(ty))"
        case let .matrix3d(values):
            return "matrix3d(\(values.map { String($0) }.joined(separator: ", ")))"
        case let .translate(x, y):
            return y != nil ? "translate(\(x), \(y!))" : "translate(\(x))"
        case let .translate3d(x, y, z):
            return "translate3d(\(x), \(y), \(z))"
        case let .translateX(x):
            return "translateX(\(x))"
        case let .translateY(y):
            return "translateY(\(y))"
        case let .translateZ(z):
            return "translateZ(\(z))"
        case let .scale(x, y):
            return y != nil ? "scale(\(x), \(y!))" : "scale(\(x))"
        case let .scale3d(x, y, z):
            return "scale3d(\(x), \(y), \(z))"
        case let .scaleX(x):
            return "scaleX(\(x))"
        case let .scaleY(y):
            return "scaleY(\(y))"
        case let .scaleZ(z):
            return "scaleZ(\(z))"
        case let .rotate(angle):
            return "rotate(\(angle))"
        case let .rotate3d(x, y, z, angle):
            return "rotate3d(\(x), \(y), \(z), \(angle))"
        case let .rotateX(angle):
            return "rotateX(\(angle))"
        case let .rotateY(angle):
            return "rotateY(\(angle))"
        case let .rotateZ(angle):
            return "rotateZ(\(angle))"
        case let .skew(x, y):
            return y != nil ? "skew(\(x), \(y!))" : "skew(\(x))"
        case let .skewX(angle):
            return "skewX(\(angle))"
        case let .skewY(angle):
            return "skewY(\(angle))"
        case let .perspective(length):
            return "perspective(\(length))"
        case let .compound(transforms):
            return transforms.map { $0.description }.joined(separator: " ")
        }
    }
}

// Convenience initializers and static properties
extension Transform {
    public static func translate(_ x: Length, _ y: Length? = nil) -> Self {
        .translate(x: x, y: y)
    }
    
    public static func scale(_ x: Double, _ y: Double? = nil) -> Self {
        .scale(x: x, y: y)
    }
    
    public static func skew(_ x: Angle, _ y: Angle? = nil) -> Self {
        .skew(x: x, y: y)
    }
}

// Operator overloading for combining transforms
extension Transform {
    public static func + (lhs: Transform, rhs: Transform) -> Transform {
        switch (lhs, rhs) {
        case (.compound(let left), .compound(let right)):
            return .compound(left + right)
        case (.compound(let left), _):
            return .compound(left + [rhs])
        case (_, .compound(let right)):
            return .compound([lhs] + right)
        default:
            return .compound([lhs, rhs])
        }
    }
}
