//
//  GridTrainerApp.swift
//  View Extension
//
//  Created by SwiftUI-Lab on 25-Jul-2020.
//  https://swiftui-lab.com/impossible-grids
//

import SwiftUI

extension View {
    func showBorder(_ color: Color, enabled: Bool) -> some View {
        self.border(color, width: enabled ? 6 : 0)
    }
}
