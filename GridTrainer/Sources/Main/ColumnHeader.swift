//
//  ColumnHeader.swift
//  ColumnHeader
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct ColumnTitle: View {
    let info: GridInfo
    let lCell: Int
    let rCell: Int
    let column: GridItem
    let addMargin: Bool
    
    var body: some View {
        let width = calculateWidth(lCell: lCell, rCell: rCell)
        
        return HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray)
                    .frame(width: width, height: 50)
                    .overlay(Text("\(column.size.description)"))
                
            if addMargin {
                Spacer().frame(width: column.spacing ?? 0)
            }
        }
    }
    
    func calculateWidth(lCell: Int, rCell: Int) -> CGFloat {
        guard rCell < self.info.cells.count else { return 0 }

        return (self.info.cells[rCell].bounds.maxX - self.info.cells[lCell].bounds.minX)
    }
 }
