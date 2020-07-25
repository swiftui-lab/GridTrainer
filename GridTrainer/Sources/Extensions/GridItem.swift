//
//  GridTrainerApp.swift
//  GridItem Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension GridItem {
    var isAdaptive: Bool { self.size.isAdaptive }
}

extension GridItem: CustomStringConvertible {
    public var description: String {
        return "GridItem(size: \(self.size.description), spacing: \(Int(self.spacing!)), alignment: \(self.alignment!.description))"
    }
}

