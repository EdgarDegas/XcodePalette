//
//  Row.swift
//  XCAssetReader
//
//  Created by iMoe Nya on 2021/11/12.
//

import Foundation

extension CSV {
    struct Row {
        let name: String
        let color: Color?
        let colorForDark: Color?
        
        init(name: String, colorset: Colorset) {
            self.name = name
            self.color = colorset.items.first {
                $0.appearances == nil ||
                $0.appearances?.isEmpty == true
            }?.color
            self.colorForDark = colorset.items.first {
                $0.appearances?.contains { appearance in
                    appearance.value == "dark"
                } == true
            }?.color
        }
        
    }
}
