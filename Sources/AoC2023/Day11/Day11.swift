import Foundation
import Algorithms

func day11part1(input: SpaceGrid) -> Int {
    let expansion = getExpansionRowsAndColumns(input: input)

    let grid = input
    print(grid)
    print(grid.width, grid.height)

    let coordinates = makeCoordinateGrid(from: input, rows: expansion.rows, columns: expansion.columns, expansionFactor: 2)
    let distances = distancesFromCoordinates(coordinates)
    return distances.map { $0.manhattanDistance }.reduce(0, +)
}

func day11part2(input: SpaceGrid) -> Int {
    let expansion = getExpansionRowsAndColumns(input: input)
    let coordinates = makeCoordinateGrid(from: input, rows: expansion.rows, columns: expansion.columns, expansionFactor: 1_000_000)
    let distances = distancesFromCoordinates(coordinates)
    return distances.map { $0.manhattanDistance }.reduce(0, +)
}

func distancesFromCoordinates(_ coordinates: [Coordinate]) -> [Distance] {
    coordinates
        .filter { $0.symbol == "#" }
        .combinations(ofCount: 2)
        .map { Distance(nodeA: $0[0], nodeB: $0[1]) }
}

func makeCoordinateGrid(from grid: SpaceGrid, rows: [Int], columns: [Int], expansionFactor: Int) -> [Coordinate] {
    var extraY = 0
    var coordinates: [Coordinate] = []
    for y in 0..<grid.height {
        if rows.contains(y) { extraY += expansionFactor - 1 }
        var extraX = 0
        for x in 0..<grid.width {
            if columns.contains(x) { extraX += expansionFactor - 1 }
            coordinates.append(Coordinate(symbol: grid.grid[y * grid.width + x], x: x + extraX, y: y + extraY))
        }
    }
    return coordinates
}

func getExpansionRowsAndColumns(input: SpaceGrid) -> (rows: [Int], columns: [Int]) {
    var rows: [Int] = []
    var columns: [Int] = []

    for y in 0..<input.height {
        let row = input.grid[y * input.width..<y * input.width + input.width]
        if row.filter({$0 == "#"}).count == 0 { rows.append(y) }
    }

    for x in 0..<input.width {
        var verticalSlice: [String] = []
        for y in 0..<input.height {
            verticalSlice.append(input.grid[y * input.width + x])
        }
        if verticalSlice.filter({ $0 == "#" }).count == 0 { columns.append(x) }
    }
    return (rows, columns)
}

struct Distance {
    let nodeA: Coordinate
    let nodeB: Coordinate

    var manhattanDistance: Int {
        abs(nodeA.x - nodeB.x) + abs(nodeA.y - nodeB.y)
    }
}
