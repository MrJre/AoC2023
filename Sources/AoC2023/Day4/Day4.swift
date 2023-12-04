import Foundation

func day4part1(input: [(winning: [Int], owned: [Int])]) -> Int {

    let scores = input.map { line in
        let count = Set(line.owned).intersection(Set(line.winning)).count

        switch count {
        case 0: return 0
        case 1: return 1
        default: return 1 << (count - 1)
        }
    }

    return scores.reduce(0, +)
}

func day4part2(input: [(winning: [Int], owned: [Int])]) -> Int {

    var doubles: [Int: Int] = [:]

    for (i, card) in input.enumerated() {
        let count = Set(card.owned).intersection(Set(card.winning)).count
        if count == 0 { continue }
        let toAdd = (doubles[i] ?? 0) + 1
        for _ in 0..<toAdd {
            for n in (i+1)...i+count {
                doubles[n] = ((doubles[n] ?? 0) + 1)
            }
        }
    }

    return doubles.values.reduce(0, +) + input.count
}
