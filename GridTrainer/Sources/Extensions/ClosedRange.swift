//
//  GridTrainerApp.swift
//  ClosedRange Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension ClosedRange: Identifiable where Bound == Int {
    // This is a little dirty, but for this short demo is good enough
    public var id: Int { self.lowerBound + self.upperBound * 100000 }
}
