import Foundation

func day1part1(input: [String]) -> Int {
    let digits = input
        .map { $0.trimmingCharacters(in: CharacterSet.decimalDigits.inverted) }
        .filter { !$0.isEmpty }
        .map(concatFirstAndLastCharToInt)

    return digits.reduce(0, +)
}

func day1part2(input: [String]) -> Int {
    let digits = input
        .map(insertDigitsForSpelledNumbers)
        .map { $0.trimmingCharacters(in: CharacterSet.decimalDigits.inverted) }
        .filter { !$0.isEmpty }
        .map(concatFirstAndLastCharToInt)

    return digits.reduce(0, +)
}

func concatFirstAndLastCharToInt(from input: String) -> Int {
    Int("\(input.first!)\(input.last!)")!
}

func insertDigitsForSpelledNumbers(input: String) -> String {
    var input = input
    let first = Number.allCases
        .compactMap { input.firstRange(of: $0.rawValue) }
        .sorted { $0.lowerBound < $1.lowerBound }
        .first
    
    if let first {
        let firstDigit = Number(rawValue: String(input[first]))!.toDigit()
        input.insert(contentsOf: firstDigit, at: first.lowerBound)
    }

    let last = Number.allCases
        .compactMap { input.range(of: $0.rawValue, options: .backwards) }
        .sorted { $0.lowerBound < $1.lowerBound }
        .last
    
    if let last {
        let lastDigit = Number(rawValue: String(input[last]))!.toDigit()
        input.insert(contentsOf: lastDigit, at: last.upperBound)
    }

    return input
}

enum Number: String, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine

    func toDigit() -> String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        }
    }
}
