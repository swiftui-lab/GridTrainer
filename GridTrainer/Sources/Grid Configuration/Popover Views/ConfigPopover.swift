//
//  GridTrainerApp.swift
//  ConfigPopover
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct ConfigPopover: View {
    @ObservedObject var cfg: GridConfiguration
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Grid Configuration")) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Item Count \(Int(self.cfg.cellCount))")
                        Slider(value: self.$cfg.cellCount, in: 0...1000, step: 1)
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Width \(Int(self.cfg.width))")
                        Slider(value: self.$cfg.width, in: 0...1500)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Spacing \(Int(self.cfg.spacing))")
                        Slider(value: self.$cfg.spacing, in: 0...100)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Padding \(Int(self.cfg.padding))")
                        Slider(value: self.$cfg.padding, in: 0...100)
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        Picker("Alignment", selection: self.$cfg.alignment) {
                            Text(".leading").tag(HorizontalAlignment.leading)
                            Text(".center").tag(HorizontalAlignment.center)
                            Text(".trailing").tag(HorizontalAlignment.trailing)
                        }
                    }.padding(5)
                                        
                    Toggle("Show borders", isOn: self.$cfg.showBorders)
                }

                Section(header: Text("Columns")) {
                    ForEach(cfg.gridItems) { item in
                        
                        let col = item.gridItem
                        
                        if let idx = cfg.gridItems.firstIndex(where: { $0.id == item.id }) {
                            
                            NavigationLink(destination: ColumnSetupView(cfg: self.cfg, idx: idx)) {
                                Text("\(col.description)")
                            }
                            .padding(20)

                        }
                        
                    }.onDelete(perform: deleteGridItem)
                    
                    Button("Add Column") {
                        self.cfg.gridItems.append(IdentifiableGridItem((self.cfg.gridItems.last?.id ?? 0) + 1, self.cfg.gridItems.last?.gridItem ?? GridItem(.fixed(50), spacing: 0, alignment: .center)))
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.trailing, 10)
        }.frame(width: 300, height: 500)
        
    }
    
    func deleteGridItem(offsets: IndexSet) {
        self.cfg.gridItems.remove(atOffsets: offsets)
    }
}
