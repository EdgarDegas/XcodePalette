//
//  Colorset+Color.swift
//  XCAssetReader
//
//  Created by iMoe Nya on 2021/11/12.
//

import Foundation

struct Color: Codable {
    let colorSpace: String
    let components: Components
    
    struct Components: Codable {
        let red: String
        let green: String
        let blue: String
        let alpha: String
    }
    
    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
    
    var asString: String {
        "#" + [
            components.red,
            components.green,
            components.blue,
            components.alpha
        ]
            .map(Self.hexFromColorString(_:))
            .joined()
    }
    
    /// E.g., 0xFF, but without the prefix 0x.
    static func hexFromColorString(_ colorString: String) -> String {
        if colorString.hasPrefix("0x") {
            return String([Character](colorString)[2...])
        } else {
            let double = Double(colorString)!
            return String(
                format: "%02X",
                Int(round(double * 255))
            )
        }
    }
}
