//
//  CSV.swift
//  XCAssetReader
//
//  Created by iMoe Nya on 2021/11/12.
//

import Foundation

struct CSV {
    var rows: [Row]
    
    static var nameHeader: String {
        "Name"
    }
    
    static var colorHeader: String {
        "Color (#RGBA)"
    }
    
    static var colorForDarkHeader: String {
        "Color for Dark (#RGBA)"
    }
    
    init(rows: [Row]) {
        self.rows = rows
    }
    
    static var delimeter: String {
        ","
    }
    
    static var lineBreak: String {
        "\n"
    }
    
    static var headerString: String {
        nameHeader + delimeter +
        colorHeader + delimeter +
        colorForDarkHeader
    }
    
    static func stringFromRow(_ row: Row) -> String {
        row.name + delimeter +
        (row.color?.asString ?? "") + delimeter +
        (row.colorForDark?.asString ?? "")
    }
    
    func asString() -> String {
        Self.headerString +
        Self.lineBreak +
        rows
            .map(Self.stringFromRow(_:))
            .joined(separator: Self.lineBreak)
    }
}
