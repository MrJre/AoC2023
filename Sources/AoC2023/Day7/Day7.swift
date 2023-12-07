import Foundation

func day7part1(input: [(Hand, Int)]) -> Int {
    let sorted = input.sorted { $0.0 < $1.0 }.map { $0 }
    return sorted.enumerated().reduce(0) { return $0 + ($1.offset + 1) * $1.element.1 }
}

func day7part2(input: [(Hand, Int)]) -> Int {
    let sorted = input.sorted { $0.0 < $1.0 }.map { $0 }
    return sorted.enumerated().reduce(0) { return $0 + ($1.offset + 1) * $1.element.1 }
}


