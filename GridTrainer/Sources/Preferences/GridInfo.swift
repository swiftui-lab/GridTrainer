//
//  GridTrainerApp.swift
//  GridInfo
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct GridInfo: Equatable {

    var size: CGSize = .zero
    var columnCount: Int = 0
    var cells: [Item] = [] { didSet { recalculate() } }
    
    var contentWidth: CGFloat {
        guard columnCount > 0 else { return 0 }
        
        let left = cells[0]
        let right = cells[self.columnCount - 1]

        return (right.bounds.maxX - left.bounds.minX)
    }
    
    var renderedCells: String {
        guard let f = cells.first?.id, let l = cells.last?.id else { return "" }
        
        return "rendering cells from \(f + 1) to \(l + 1)"
    }
  
    func cellWidth(_ col: Int) -> CGFloat {
        columnCount > 0 ? cells[col % columnCount].bounds.width : 0
    }
    
    mutating func recalculate() {
        self.columnCount = calculateColumnCount()
    }

    func calculateColumnCount() -> Int {

        guard cells.count > 1 else { return cells.count }

        var k = 1

        for i in 1..<cells.count {
            if cells[i].bounds.origin.x > cells[i-1].bounds.origin.x {
                k += 1
            } else {
                break
            }
        }

        return k
    }
    
    // Made equatable, to avoid unnecessary view body computations
    struct Item: Equatable {
        let id: Int
        let bounds: CGRect
    }    
}
