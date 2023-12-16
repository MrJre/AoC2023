import Foundation

func day13part1(input: [MirrorGrid]) -> Int {
    input.map { findReflections(for: $0) }.reduce(0, +)
}

func day13part2(input: [MirrorGrid]) -> Int {
    input.map { findReflections(for: $0, shouldFindSmudge: true) }.reduce(0, +)
}

func findReflections(for grid: MirrorGrid, shouldFindSmudge: Bool = false) -> Int {
    let horizontal = findHorizontalReflectionLines(for: grid)
    let hScore: Int
    if shouldFindSmudge {
        hScore = findSmudge(rows: horizontal.0)?.3 ?? 0
    } else {
        hScore = checkPossibleReflections(rows: horizontal.0, reflectionIndices: horizontal.1) ?? 0
    }

    let vertical = findVerticalReflection(for: grid)
    let vScore: Int
    if shouldFindSmudge {
        vScore = findSmudge(rows: vertical.0)?.3 ?? 0
    } else {
        vScore = checkPossibleReflections(rows: vertical.0, reflectionIndices: vertical.1) ?? 0
    }

    return (hScore * 100) + vScore
}

func findHorizontalReflectionLines(for grid: MirrorGrid) -> ([[GroundType]], [Int]) {
    var possibleReflections: [Int] = []
    var rows: [[GroundType]] = []

    for y in 0..<grid.height {
        let lineA = grid.elements[y * grid.width..<y * grid.width + grid.width]
        var lineB: ArraySlice<GroundType>?
        if y < grid.height - 1 {
            lineB = grid.elements[(y + 1) * grid.width..<(y + 1) * grid.width + grid.width]
        }

        if lineA == lineB {
            possibleReflections.append(y)
        }

        rows.append(Array(lineA))
    }
    return (rows, possibleReflections)
}

func findVerticalReflection(for grid: MirrorGrid) -> ([[GroundType]], [Int]) {
    var possibleReflectionXs: [Int] = []
    var columns: [[GroundType]] = []

    for x in 0..<grid.width {
        var lineA: [GroundType] = []
        var lineB: [GroundType] = []
        for y in 0..<grid.height {
            lineA.append(grid.elements[y * grid.width + x])
            if x < grid.width - 1 {
                lineB.append(grid.elements[y * grid.width + x + 1])
            }
        }

        if lineA == lineB {
            possibleReflectionXs.append(x)
        }

        columns.append(lineA)
    }
    return (columns, possibleReflectionXs)
}

func findSmudge(rows: [[GroundType]]) -> (Int, Int, (GroundType, GroundType), Int)? {
    for (i, rowA) in rows.enumerated() {
        for (j, rowB) in rows.enumerated() {
            if i == j { continue }
            let changes = changesInLines(lineA: rowA, lineB: rowB)
            let reflectionIndex = (i + j) / 2
            if changes.count == 1, let change = changes.first {
                var rows = rows
                rows[i] = rowGivenChange(row: rowA, change: change)
                if let reflection = checkPossibleReflections(rows: rows, reflectionIndices: [reflectionIndex]) {
                    return (i, change.0, change.1, reflection)
                }
            }
        }
    }
    return nil
}

func changesInLines(lineA: [GroundType], lineB: [GroundType]) -> [(Int, (GroundType, GroundType))] {
    zip(lineA, lineB).enumerated().filter { $1.0 != $1.1 }
}

func rowGivenChange(row: [GroundType], change: (Int, (GroundType, GroundType))) -> [GroundType] {
    var row = row
    row[change.0] = change.1.1
    return row
}

func checkPossibleReflections(rows: [[GroundType]], reflectionIndices: [Int]) -> Int? {
    guard reflectionIndices.count > 0 else { return nil }

    for reflectionIndex in reflectionIndices {
        var isValidReflection = true
        for i in 0...reflectionIndex {
            let mirror = (2 * reflectionIndex) + 1 - i
            if mirror >= rows.count { continue }
            isValidReflection = isValidReflection && rows[i] == rows[mirror]
        }
        if isValidReflection { return reflectionIndex + 1 }
    }

    return nil
}
