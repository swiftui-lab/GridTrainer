//
//  GridTrainerApp.swift
//  IdentifiableGridItem
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct IdentifiableGridItem: Identifiable {
    let id: Int
    var gridItem: GridItem

    init(_ id: Int, _ gridItem: GridItem) {
        self.id = id
        self.gridItem = gridItem
    }
}
