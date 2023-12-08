import Foundation

func day8part1(input: ([Direction], [String: Node])) -> Int {
    let directions = input.0
    let map = input.1

    return findSteps(directions: directions, map: map, startNode: map["AAA"]!) { node in
        node.name == "ZZZ"
    }
}

func day8part2(input: ([Direction], [String: Node])) -> Int {
    let directions = input.0
    let map = input.1

    let allSteps = map.values.filter { $0.name.hasSuffix("A") }.map {
        findSteps(directions: directions, map: map, startNode: $0) { node in
            node.name.hasSuffix("Z")
        }
    }

    return findLeastCommonMultiplier(numbers: allSteps)
}

func findLeastCommonMultiplier(numbers: [Int]) -> Int {
    var result = numbers[0]
    for i in 1..<numbers.count {
        result = findLeastCommonMultiplier(a: result, b: numbers[i])
    }

    return result
}

func findLeastCommonMultiplier(a: Int, b: Int) -> Int {
    abs(a * b) / findGreatestCommonDenominator(a: a, b: b)
}

func findGreatestCommonDenominator(a: Int, b: Int) -> Int {
    return b > 0 ? findGreatestCommonDenominator(a: b, b: a % b) : a
}

func findSteps(directions: [Direction], map: [String: Node], startNode: Node, endCondition: (Node)->Bool) -> Int {
    var currentNode = startNode
    var directionsIndex = 0
    var steps = 0

    while !endCondition(currentNode) {
        if directionsIndex == directions.count { directionsIndex = 0 }
        switch directions[directionsIndex] {
        case .left: currentNode = map[currentNode.left]!
        case .right: currentNode = map[currentNode.right]!
        }

        directionsIndex = directionsIndex + 1
        steps = steps + 1
    }

    return steps
}
