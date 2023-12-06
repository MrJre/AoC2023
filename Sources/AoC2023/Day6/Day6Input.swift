import Foundation
import RegexBuilder

func parseDay6InputPart1(from file: String) -> [Race] {
    let result = file.components(separatedBy: "\n")
    let timeString = result[0].components(separatedBy: ":")[1]
    let distanceString = result[1].components(separatedBy: ":")[1]

    let times = parse(string: timeString)
    let distances = parse(string: distanceString)

    var races: [Race] = []

    for (i, time) in times.enumerated() {
        let distance = distances[i]
        races.append(Race(time: time, distance: distance))
    }

    return races
}

func parse(string: String) -> [Int] {
    let trimmed = string.trimmingCharacters(in: .whitespaces)
    let regex = Regex {
        OneOrMore {
            Capture { OneOrMore(.digit) } transform: { substring -> Int in Int(String(substring))! }
        }
    }
    return trimmed.matches(of: regex).map { $0.output.1 }
}

func parseDay6InputPart2(from file: String) -> Race {
    let result = file.components(separatedBy: "\n")
    let timeString = result[0].components(separatedBy: ":")[1]
    let distanceString = result[1].components(separatedBy: ":")[1]

    let time = Int(timeString.filter { !$0.isWhitespace })!
    let distance = Int(distanceString.filter { !$0.isWhitespace })!

    return Race(time: time, distance: distance)
}



struct Race {
    let time: Int
    let distance: Int
}
