import Foundation

func day2part1(input: [Game]) -> Int {
    let configuration = (reds: 12, greens: 13, blues: 14)
    return input.map { validGameScore(game: $0, configuration: configuration) }.reduce(0, +)
}

func day2part2(input: [Game]) -> Int {
    let configuration = (reds: 12, greens: 13, blues: 14)
    return input.map { fewestCubesGameScore(game: $0, configuration: configuration) }.reduce(0, +)
}

func validGameScore(game: Game, configuration: (reds: Int, greens: Int, blues: Int)) -> Int {
    for set in game.sets {
        for cube in set.cubes {
            switch cube.color {
            case .red: if cube.count > configuration.reds { return 0 }
            case .blue: if cube.count > configuration.blues { return 0 }
            case .green: if cube.count > configuration.greens { return 0 }
            }
        }
    }

    return game.id
}

func fewestCubesGameScore(game: Game, configuration: (reds: Int, greens: Int, blues: Int)) -> Int {
    var reds: Int = 0
    var greens: Int = 0
    var blues: Int = 0

    for set in game.sets {
        for cube in set.cubes {
            switch cube.color {
            case .red: reds = max(reds, cube.count)
            case .blue: blues = max(blues, cube.count)
            case .green: greens = max(greens, cube.count)
            }
        }
    }
    return reds * greens * blues
}
