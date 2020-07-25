//
//  GridTrainerApp.swift
//  GridConfiguration
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI


class GridConfiguration: ObservableObject {
    @Published var gridItems = [IdentifiableGridItem]()
    @Published var spacing: CGFloat = 20
    @Published var width: CGFloat = 1000
    @Published var padding: CGFloat = 20
    @Published var cellCount: Double = 200
    @Published var alignment: HorizontalAlignment = .center
    @Published var showBorders: Bool = false
    
    var itemCount: Int { Int(cellCount) }
    
    init() {
        let s: CGFloat = 20
        
        self.gridItems = [
            IdentifiableGridItem(1, GridItem(.fixed(80), spacing: s, alignment: .center)),
            IdentifiableGridItem(3, GridItem(.adaptive(minimum: 60, maximum: 80), spacing: s, alignment: .center)),
            IdentifiableGridItem(4, GridItem(.flexible(minimum: 60, maximum: 240), spacing: s, alignment: .center)),
            IdentifiableGridItem(5, GridItem(.fixed(90), spacing: s, alignment: .center))
        ]
    }
    
    func colSpacing(_ idx: Int) -> Binding<CGFloat> {
        Binding<CGFloat>(get: { self.gridItems[idx].gridItem.spacing ?? 0},
                         set: { self.gridItems[idx].gridItem.spacing = $0 })
    }

    func colAlignment(_ idx: Int) -> Binding<Alignment> {
        Binding<Alignment>(get: { self.gridItems[idx].gridItem.alignment ?? .center},
                           set: { self.gridItems[idx].gridItem.alignment = $0 })
    }
    
    func colSizeType(_ idx: Int) -> Binding<Int> {
        Binding<Int>(get: { self.gridItems[idx].gridItem.size.sizeType },
                     set: {
                        let (min, max) = self.gridItems[idx].gridItem.size.minMax
                        
                        switch $0 {
                            case 1: // fixed
                                self.gridItems[idx].gridItem.size = .fixed(min)
                            case 2: // flexible
                                self.gridItems[idx].gridItem.size = .flexible(minimum: min, maximum: max)
                            case 3: // adaptive
                                self.gridItems[idx].gridItem.size = .adaptive(minimum: min, maximum: max)
                            default:
                                fatalError()
                        }
                     })
    }

    func colSizeMin(_ idx: Int) -> Binding<CGFloat> {
        Binding<CGFloat>(get: { self.gridItems[idx].gridItem.size.minMax.0 },
                         set: {
                            switch self.gridItems[idx].gridItem.size {
                                case .fixed(_):
                                    self.gridItems[idx].gridItem.size = .fixed($0)
                                case .flexible(_, let m):
                                    self.gridItems[idx].gridItem.size = .flexible(minimum: $0, maximum: max(m, $0))
                                case .adaptive(_, let m):
                                    self.gridItems[idx].gridItem.size = .adaptive(minimum: $0, maximum: max(m, $0))
                                @unknown default:
                                    fatalError()
                            }
                         })
    }
    
    func colSizeMax(_ idx: Int) -> Binding<CGFloat> {
        Binding<CGFloat>(get: { self.gridItems[idx].gridItem.size.minMax.1 },
                         set: {
                            switch self.gridItems[idx].gridItem.size {
                                case .flexible(let m, _):
                                    self.gridItems[idx].gridItem.size = .flexible(minimum: min(m, $0), maximum: $0)
                                case .adaptive(let m, _):
                                    self.gridItems[idx].gridItem.size = .adaptive(minimum: min(m, $0), maximum: $0)
                                default:
                                    break
                            }
                         })
    }
}

