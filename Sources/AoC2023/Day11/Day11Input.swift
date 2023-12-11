import Foundation

func parseDay11Input(from file: String) -> SpaceGrid {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }

    let width = result[0].count
    let height = result.count

    let grid = result.flatMap { $0.map { $0 } }.map(String.init)

    return SpaceGrid(grid: grid, width: width, height: height)
}

struct SpaceGrid {
    var grid: [String]
    var width: Int
    var height: Int
}

extension SpaceGrid: CustomDebugStringConvertible {
    var debugDescription: String {
        var result = ""
        for y in 0..<height {
            result.append(grid[y * width..<y * width + width].reduce("") { $0 + $1.debugDescription })
            result.append("\n")
        }
        return result
    }
}

struct Coordinate {
    var symbol: String
    var x: Int
    var y: Int
}

extension Coordinate: CustomDebugStringConvertible {
    var debugDescription: String { symbol }
}
