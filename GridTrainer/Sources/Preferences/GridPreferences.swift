//
//  GridTrainerApp.swift
//  GridInfoPreference
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

struct GridInfoPreference {
    let id: Int
    let bounds: Anchor<CGRect>
}

struct GridPreferenceKey: PreferenceKey {
    static var defaultValue: [GridInfoPreference] = []
    
    static func reduce(value: inout [GridInfoPreference], nextValue: () -> [GridInfoPreference]) {
        return value.append(contentsOf: nextValue())
    }
}

extension View {
    func gridInfo(id: Int) -> some View {
        self.anchorPreference(key: GridPreferenceKey.self, value: .bounds) {
                [GridInfoPreference(id: id, bounds: $0)]
            }
    }
    
    func gridConfiguration(_ info: Binding<GridInfo>) -> some View {
        self.backgroundPreferenceValue(GridPreferenceKey.self) { prefs in
            GeometryReader { proxy -> Color in
                DispatchQueue.main.async {
                    info.wrappedValue.size = proxy.size
                    info.wrappedValue.cells = prefs.compactMap {
                        GridInfo.Item(id: $0.id, bounds: proxy[$0.bounds])
                    }
                }
                    
                return Color.clear
            }
        }
    }
}
