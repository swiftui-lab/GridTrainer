//
//  GridHeader.swift
//  GridHeader
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct GridHeader: View {
    let cfg: GridConfiguration
    let info: GridInfo
    
    internal init(_ cfg: GridConfiguration, _ info: GridInfo) {
        self.cfg = cfg
        self.info = info
    }
    
    var body: some View {
        Group {
            if let correspondance = calculateCorrespondance() {
                HStack(spacing: 0) {
                    ForEach(correspondance) { (range: ClosedRange) -> ColumnTitle? in
                        if let idx = correspondance.firstIndex(where: { $0 == range }) {
                            return ColumnTitle(info: info,
                                               lCell: range.lowerBound,
                                               rCell: range.upperBound,
                                               column: self.cfg.gridItems[idx].gridItem,
                                               addMargin: range != correspondance.last)
                        } else {
                            return nil
                        }
                    }                    
                }
                .frame(width: info.size.width, alignment: alignmentForHStack())
                
            } else {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray)
                    .frame(height: 50)
                    .overlay(Text("With more than one adaptive GridItem, it is difficult to determine which cells belong to which columns"))
                    
            }
        }.font(.footnote)
        
    }
    
    func alignmentForHStack() -> Alignment {
        switch self.cfg.alignment {
            case .leading:
                return .leading
            case .center:
                return .center
            case .trailing:
                return .trailing
            default:
                return .center
        }
    }
    
    func calculateCorrespondance() -> [ClosedRange<Int>]? {
        var array = [ClosedRange<Int>]()
        
        let adaptiveCount = self.cfg.gridItems.filter({ $0.gridItem.isAdaptive }).count
        
        guard adaptiveCount < 2 else {
            // If more than one adaptive GridItem is specified, it is hard to determine
            // which of the actual columns belong to which adaptive GridItem. There is
            // some guessing that can be done, but it is not worth the effort for this
            // project
            return nil
        }
        
        // Match cells columns, with their corresponding GridItem
        var k = 0
        
        for col in 0..<self.cfg.gridItems.count {
            
            let from = k
            let to = (k + (cfg.gridItems[col].gridItem.isAdaptive ? max(0, self.info.columnCount - (self.cfg.gridItems.count - adaptiveCount) - 1) : 0))

            array.append(from...to)
            
            k = to + 1
        }
        
        return array
    }
}

