//
//  GridTrainerApp.swift
//  HorizontalAlignment Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension HorizontalAlignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.description)
    }
}

extension HorizontalAlignment: CustomStringConvertible {
    public var description: String {
        switch self {
            case .leading:
                return ".leading"
            case .center:
                return ".center"
            case .trailing:
                return ".trailing"
            default:
                return "?"
        }
    }
}
