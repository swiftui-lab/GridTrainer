//
//  GridTrainerApp.swift
//  ColumnSetupView
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct ColumnSetupView: View {
    @ObservedObject var cfg: GridConfiguration
    let idx: Int
    
    var body: some View {

        Form {
            Section(header: Text("Column #\(idx + 1)")) {
                
                if idx >= 0 && idx < self.cfg.gridItems.count {
                    let gridItem = self.cfg.gridItems[idx].gridItem
                    
                    Text("\(gridItem.description)")
                        .padding(10)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Picker("Size Type", selection: self.cfg.colSizeType(idx)) {
                            Text(".fixed()").tag(1)
                            Text(".flexible()").tag(2)
                            Text(".adaptive()").tag(3)
                        }
                    }.padding(5)
                    
                    VStack {
                        HStack {
                            VStack {
                                Text(gridItem.size.hasMax ? "Minimum" : "Fixed Width")
                                Slider(value: self.cfg.colSizeMin(idx), in: 0...300)
                            }
                            
                            if gridItem.size.hasMax {
                                VStack {
                                    Text("Maximum")
                                    Slider(value: self.cfg.colSizeMax(idx), in: 0...400)
                                }
                            }
                        }
                    }
                    
                    VStack {
                        VStack {
                            Text("Spacing")
                            Slider(value: self.cfg.colSpacing(idx), in: 0...100)
                        }
                    }
                    
                    // Changing the alignment will not produce any visible effects,
                    // because the cell views are expanding to occupy all the space
                    // offered by the grid. If the cells are changed to a different size
                    // this option will become relevant.
                    VStack(alignment: .leading, spacing: 0) {
                        Picker("Alignment", selection: self.cfg.colAlignment(idx)) {
                            Text(".leading").tag(Alignment.leading)
                            Text(".center").tag(Alignment.center)
                            Text(".trailing").tag(Alignment.trailing)
                        }
                    }.padding(5)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
