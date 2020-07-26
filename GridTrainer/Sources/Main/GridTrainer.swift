//
//  GridTrainer.swift
//  GridTrainer
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct GridTrainer: View {
    // Grid Configuration
    @StateObject private var cfg = GridConfiguration()
    
    // A flag to recreate the grid, tied to the refresh button in the toolbar
    // This is needed when current Lazy[VH]]Grid bugs corrupt the layout, to
    // force a redraw.
    @State private var resetFlag = true
    
    // Information of the grid cells and sizes
    @State private var info = GridInfo()
    
    // Boolean to display the popover with the config panel
    @State private var showConfigPanel: Bool = false
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    func color(_ idx: Int) -> Color {
        colors[idx % max(1, min(info.columnCount, 7))]
    }
    
    var body: some View {
        let titleCount = "Column count = \(self.info.columnCount)"
        let titleRendered = "\(self.cfg.itemCount == 0 ? "" : ", \(self.info.renderedCells) of \(self.cfg.itemCount)")"
        
        return NavigationView {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: cfg.gridItems.compactMap { $0.gridItem },
                              alignment: cfg.alignment,
                              spacing: cfg.spacing,
                              pinnedViews: .sectionHeaders) {
                        
                        Section(header: GridHeader(self.cfg, self.info) ) {
                            
                            ForEach(0..<self.cfg.itemCount, id: \.self) { cellIdx in
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(color(cellIdx))
                                    .frame(height: 100)
                                    .overlay(
                                        Text("Cell \(cellIdx + 1)\nWidth \(Int(self.info.cellWidth(cellIdx)))")
                                            .multilineTextAlignment(.center)
                                    )
                                    .shadow(radius: 8)
                                    .gridInfo(id: cellIdx)
                                
                            }
                            
                        }.font(.callout)
                    }
                    .showBorder(.gray, enabled: self.cfg.showBorders)
                    .frame(width: self.cfg.width)
                    .gridConfiguration($info)
                    .padding(self.cfg.padding)
                    .showBorder(.blue, enabled: self.cfg.showBorders)
                    .id(self.resetFlag)
                }
                .showBorder(.black, enabled: self.cfg.showBorders)
                .navigationTitle(titleCount + titleRendered)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showConfigPanel = true
                        }, label: {
                            Image(systemName: "square.split.2x2.fill").frame(width: 40)
                        })
                        .popover(isPresented: self.$showConfigPanel, attachmentAnchor: .point(.bottomTrailing)) {
                            ConfigPopover(cfg: self.cfg)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu(content: {
                            VStack {
                                    
                                Text("Pre-configured GridItems").fontWeight(.heavy)
                                Divider()
                                Button("Fix + Fix + Fix") { self.cfg.gridItems = GridConfiguration.presetFixFixFix }
                                Button("Fix + Flex + Fix") { self.cfg.gridItems = GridConfiguration.presetFixFlexFix }
                                Button("Flex + Fix + Flex") { self.cfg.gridItems = GridConfiguration.presetFlexFixFlex }
                                Button("Fix + Adapt + Fix") { self.cfg.gridItems = GridConfiguration.presetFixAdaptFix }
                                Button("Fix + Flex + Adapt + Fixed")  { self.cfg.gridItems = GridConfiguration.presetFixFlexAdaptFix }
                            }
                        }, label: {
                            Image(systemName: "square.split.2x1.fill").frame(width: 40)
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.resetFlag.toggle()
                        }, label: {
                            Image(systemName: "arrow.uturn.down.square.fill").frame(width: 40)
                        })
                    }
                    

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }   
}
