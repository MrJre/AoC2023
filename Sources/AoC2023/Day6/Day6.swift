import Foundation

func day6part1(input: [Race]) -> Int {
    let wins: [Int] = input.map { race in
        let calc = calcZeroY(a: -1, b: race.time, c: -race.distance).sorted()
        let first = Int(floor(calc.first!)) + 1
        let last = Int(ceil(calc.last!)) - 1
        return (first...last).count
    }

    return wins.filter { $0 != 0 }.reduce(1, *)
}

func day6part2(input race: Race) -> Int {
    let calc = calcZeroY(a: -1, b: race.time, c: -race.distance).sorted()
    let first = Int(floor(calc.first!)) + 1
    let last = Int(ceil(calc.last!)) - 1
    return (first...last).count
}

func calcZeroY(a: Int, b: Int, c: Int) -> [Double] {
    let first = (-Double(b) - sqrt(pow(Double(b), 2) - (4 * Double(a) * Double(c)))) / (2 * Double(a))
    let second = (-Double(b) + sqrt(pow(Double(b), 2) - (4 * Double(a) * Double(c)))) / (2 * Double(a))

    return [first, second]
}
