//
//  File.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 15/09/2024.
//

import Foundation

public enum PageBreak {
    case after(After = .auto)
    case before(Before = .auto)
    case inside(Inside = .auto)
    
    public enum After: String {
        case auto
        case always
        case avoid
        case left
        case right
        case initial
        case inherit
    }
    public enum Before: String {
        case auto
        case always
        case avoid
        case left
        case right
        case initial
        case inherit
    }
    public enum Inside: String {
        case auto
        case avoid
        case initial
        case inherit
    }
    
    var description: (String, String) {
        switch self {
        case .after(let after):
            ("page-break-after", after.rawValue)
        case .before(let before):
            ("page-break-before", before.rawValue)
        case .inside(let inside):
            ("page-break-inside", inside.rawValue)
        }
    }
}

