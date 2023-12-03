import Foundation

func day3part1(input: (parts: [PartNumber], symbols: [Symbol])) -> Int {
    var parts: [PartNumber] = []

    for part in input.parts {
        let interestingSymbols = input.symbols.filter { (part.y-1...part.y+1).contains($0.y) }

        let symbolsInRange = interestingSymbols.filter { (part.range.lowerBound-1...part.range.upperBound+1).contains($0.x) }
        if !symbolsInRange.isEmpty {
            parts.append(part)
        }
    }

    return parts.reduce(0) {
        return $0 + $1.number
    }
}

func day3part2(input: (parts: [PartNumber], symbols: [Symbol])) -> Int {
    var ratios: [Int] = []

    let gears = input.symbols.filter { $0.symbol == "*" }

    for gear in gears {
        let interestingParts = input.parts.filter { ($0.y-1...$0.y+1).contains(gear.y) }
        let partsInRange = interestingParts.filter { ($0.range.lowerBound-1...$0.range.upperBound+1).contains(gear.x) }

        if partsInRange.count == 2 {
            ratios.append(partsInRange[0].number * partsInRange[1].number)
        }
    }

    return ratios.reduce(0, +)
}
