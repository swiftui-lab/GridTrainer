//
//  GridTrainerApp.swift
//  GridItem.Size Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension GridItem.Size {
    var isAdaptive: Bool { self.sizeType == 3 }
    
    var sizeType: Int {
        switch self {
            case .fixed(_):
                return 1
            case .flexible(_, _):
                return 2
            case .adaptive(_, _):
                return 3
            @unknown default:
                fatalError()
        }
    }
}

extension GridItem.Size {
    var minMax: (CGFloat, CGFloat) {
        switch self {
        case .fixed(let minimum):
            return (minimum, minimum)
        case .flexible(minimum: let minimum, maximum: let maximum):
            return (minimum, maximum)
        case .adaptive(minimum: let minimum, maximum: let maximum):
            return (minimum, maximum)
        @unknown default:
            fatalError()
        }
    }
}

extension GridItem.Size {
    var hasMax: Bool {
        switch self {
            case .fixed(_):
                return false
            default:
                return true
        }
    }
}

extension GridItem.Size: CustomStringConvertible {
    public var description: String {
        switch self {
            case .fixed(let w):
                return ".fixed(\(Int(w)))"
            case .flexible(let min, let max):
                return ".flexible(minimum: \(Int(min)), maximum: \(Int(max)))"
            case .adaptive(let min, let max):
                return ".adaptive(minimum: \(Int(min)), maximum: \(Int(max)))"
            @unknown default:
                fatalError()
        }
    }
}
