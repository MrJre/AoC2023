import Foundation

func day9part1(input: [[Int]]) -> Int {
    input.map { $0.last! + findNextIncrement(for: $0) }.reduce(0, +)
}

func day9part2(input: [[Int]]) -> Int {
    input.map { $0.first! - findPreviousIncrement(for: $0) }.reduce(0, +)
}

func findNextIncrement(for row: [Int]) -> Int {
    let derivative = zip(row, row.dropFirst()).map { $0.1 - $0.0 }
    if row.allSatisfy({ $0 == 0 }) { return 0 }
    return derivative.last! + findNextIncrement(for: derivative)
}

func findPreviousIncrement(for row: [Int]) -> Int {
    let derivative = zip(row, row.dropFirst()).map { $0.1 - $0.0 }
    if row.allSatisfy({ $0 == 0 }) { return 0 }
    return derivative.first! - findPreviousIncrement(for: derivative)
}

