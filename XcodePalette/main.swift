//
//  main.swift
//  XCAssetReader
//
//  Created by iMoe Nya on 2021/11/5.
//

import Foundation

let path = CommandLine.arguments[1]
let assetsURL = URL(fileURLWithPath: path)

let jsonFilename = "Contents.json"
let decoder = JSONDecoder()

let fileManager = FileManager.default
let enumerator = fileManager.enumerator(
    at: assetsURL,
    includingPropertiesForKeys: [.nameKey, .isDirectoryKey],
    options: []
)!

let rows = try! enumerator.compactMap { (element: Any) throws -> CSV.Row? in
    guard let fileURL = element as? URL else {
        fatalError()
    }
    let resources = try! fileURL.resourceValues(
        forKeys: [.nameKey, .isDirectoryKey]
    )
    let isDirectory = resources.isDirectory!
    let name = resources.name!
    guard isDirectory, name.hasSuffix("colorset") else {
        return nil
    }
    var pathComponents = fileURL.pathComponents
    pathComponents.removeAll {  // keep only the relative part of path
        assetsURL.pathComponents.contains($0)
    }
    pathComponents.removeLast()  // remove the name of colorset
    // add it back, but without the file extension ".colorset"
    pathComponents.append(String(name.split(separator: ".")[0]))
    let colorsetName = pathComponents.joined(separator: ".")
    
    return CSV.Row(
        name: colorsetName,
        colorset: .init(colorsetURL: fileURL)
    )
}

let csv = CSV(rows: rows)
let currentDirectory = fileManager.currentDirectoryPath

print("Colors saved at:")
let destination = URL(fileURLWithPath: currentDirectory)
    .appendingPathComponent("colors.csv", isDirectory: false)
print(destination)
try! csv.asString().data(using: .utf8)!.write(to: destination)

