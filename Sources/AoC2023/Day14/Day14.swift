import Foundation

func day14part1(input: RockGrid) -> Int {
    let columns = tilt(lines: makeColumns(from: input))
    return columns.reduce(0) { $0 + scoreColumn(column: $1) }
}

func day14part2(input: RockGrid) -> Int {
    var grid = input
    var uniques: Set<[RockType]> = []
    var configs: [RockGrid] = []

    var cycleStart = 0

    for _ in 0..<1000000000 {
        grid = cycle(grid: grid)
        if !uniques.contains(grid.elements) {
            configs.append(grid)
            uniques.insert(grid.elements)
        } else {
            cycleStart = configs.firstIndex { $0.elements == grid.elements }!
            break
        }
    }

    let cycle = Array(configs.dropFirst(cycleStart))
    let result = makeColumns(from: cycle[(1000000000 - cycleStart - 1) % cycle.count])
    return result.reduce(0) { $0 + scoreColumn(column: $1) }
}

func cycle(grid: RockGrid) -> RockGrid {
    var grid = grid
    for direction in 0..<4 {
        switch direction % 4 {
        case 0:
            let columns = tilt(lines: makeColumns(from: grid))
            grid = makeGridFromColumns(columns)
        case 1:
            let rows = tilt(lines: makeRows(from: grid))
            grid = makeGridFromRows(rows)
        case 2:
            let columns = tilt(lines: makeColumns(from: grid).map { $0.reversed() }).map { Array($0.reversed()) }
            grid = makeGridFromColumns(columns)
        case 3:
            let rows = tilt(lines: makeRows(from: grid).map { $0.reversed() }).map { Array($0.reversed()) }
            grid = makeGridFromRows(rows)
        default:
            break
        }
    }
    return grid
}

func tilt(lines: [[RockType]]) -> [[RockType]] {
    var lines = lines
    for (columnIndex, column) in lines.enumerated() {
        var column = column
        for rockIndex in 0..<column.count {
            if rockIndex == 0 { continue }
            var currentIndex = rockIndex
            while currentIndex > 0 {
                if column[currentIndex - 1] == .none && column[currentIndex] == .round {
                    column[currentIndex - 1] = column[currentIndex]
                    column[currentIndex] = .none
                }
                currentIndex = currentIndex - 1
            }
        }

        lines[columnIndex] = column
    }
    return lines
}

func makeColumns(from grid: RockGrid) -> [[RockType]] {
    var columns: [[RockType]] = []
    for x in 0..<grid.width {
        var line: [RockType] = []
        for y in 0..<grid.height {
            line.append(grid.elements[y * grid.width + x])
        }
        columns.append(line)
    }
    return columns
}

func makeGridFromColumns(_ columns: [[RockType]]) -> RockGrid {
    let width = columns.count
    let height = columns[0].count
    var elements: [RockType] = []
    for x in 0..<width {
        for y in 0..<height {
            elements.append(columns[y][x])
        }
    }
    return RockGrid(width: width, height: height, elements: elements)
}

func makeRows(from grid: RockGrid) -> [[RockType]] {
    var rows: [[RockType]] = []
    for y in 0..<grid.height {
        rows.append(Array(grid.elements[y * grid.width..<y * grid.width + grid.width]))
    }
    return rows
}

func makeGridFromRows(_ rows: [[RockType]]) -> RockGrid {
    let width = rows[0].count
    let height = rows.count
    return RockGrid(width: width, height: height, elements: rows.flatMap { $0 })
}

func scoreColumn(column: [RockType]) -> Int {
    var score = 0
    for i in 0..<column.count {
        if column[i] == .round {
            score += (column.count - i)
        }
    }
    return score
}
