import Foundation
import RegexBuilder

var cache: [SpringRow: Int] = [:]

func day12part1(input: [SpringRow]) -> Int {
    input.map { solve(for: $0.configuration, arrangement: $0.arrangement) }.reduce(0, +)
}

func day12part2(input: [SpringRow]) -> Int {
    let input = unfold(input: input)
    return input.map { solve(for: $0.configuration, arrangement: $0.arrangement) }.reduce(0, +)
}

func unfold(input: [SpringRow]) -> [SpringRow] {
    input.map { line in
        var configuration: [[String]] = []
        var arrangement: [Int] = []
        for _ in 0..<5 {
            configuration.append(line.configuration)
            arrangement.append(contentsOf: line.arrangement)
        }
        let resultingConfig = configuration.joined(by: ["?"]).flatMap{ $0 }.map(String.init)
        return SpringRow(configuration: resultingConfig, arrangement: arrangement)
    }
}

func solve(for configuration: [String], arrangement: [Int]) -> Int {
    if configuration.isEmpty {
        if arrangement.isEmpty { return 1 }
        else { return 0 }
    }

    if arrangement.isEmpty {
        if configuration.contains("#") { return 0 }
        else { return 1 }
    }

    if cache[SpringRow(configuration: configuration, arrangement: arrangement)] != nil {
        return cache[SpringRow(configuration: configuration, arrangement: arrangement)]!
    }

    var result = 0

    if configuration[0] == "." || configuration[0] == "?" {
        result += solve(for: Array(configuration.dropFirst()), arrangement: arrangement)
    }
    if (configuration[0] == "#" || configuration[0] == "?") &&
        arrangement[0] <= configuration.count &&
        !configuration[0..<arrangement[0]].contains(".") &&
        (arrangement[0] == configuration.count || configuration[arrangement[0]] != "#") {

        result += solve(for: Array(configuration.dropFirst(arrangement[0] + 1)), arrangement: Array(arrangement.dropFirst()))
    }

    cache[SpringRow(configuration: configuration, arrangement: arrangement)] = result

    return result
}
