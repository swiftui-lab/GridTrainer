//
//  GridTrainerApp.swift
//  Alignment Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension Alignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.description)
    }
}

extension Alignment: CustomStringConvertible {
    public var description: String {
        switch self {
            case .leading:
                return ".leading"
            case .center:
                return ".center"
            case .trailing:
                return ".trailing"
            case .topLeading:
                return ".topLeading"
            case .top:
                return ".top"
            case .topTrailing:
                return ".topTrailing"
            case .bottomLeading:
                return ".bottomLeading"
            case .bottom:
                return ".bottom"
            case .bottomTrailing:
                return ".bottomTrailing"
            default:
                return "?"
        }
    }
}
