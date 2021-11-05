//
//  Colorset.swift
//  XCAssetReader
//
//  Created by iMoe Nya on 2021/11/12.
//

import Foundation

struct Colorset: Codable {
    var items: [Item]
    let info: Info
    
    init(colorsetURL: URL) {
        let jsonFile = colorsetURL.appendingPathComponent(
            jsonFilename,
            isDirectory: false
        )
        let data = try! Data(contentsOf: jsonFile)
        self = try! decoder.decode(Colorset.self, from: data)
    }
    
    enum CodingKeys: String, CodingKey {
        case items = "colors"
        case info
    }
}


extension Colorset {
    struct Info: Codable {
        var author: String
        var version: Int
    }
    
    struct Item: Codable {
        let appearances: [Appearance]?
        let color: Color?
        
        struct Appearance: Codable {
            /*
             {
               "appearance" : "luminosity",
               "value" : "light"
             }
             */
            
            let appearance: String
            let value: String
        }
    }
}
