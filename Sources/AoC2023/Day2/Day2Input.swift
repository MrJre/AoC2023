import Foundation
import RegexBuilder

// Game 1: 20 green, 3 red, 2 blue; 9 red, 16 blue, 18 green; 6 blue, 19 red, 10 green; 12 red, 19 green, 11 blue

func parseDay2Input(from file: String) -> [Game] {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }
    return result.map(parseGameLine)
}

func parseGameLine(line: String) -> Game {
    let gameComponents = line.components(separatedBy: ":")
    let gameNumber = parseGameNumber(game: gameComponents[0])
    let sets = parseSets(sets: gameComponents[1])

    return Game(id: gameNumber, sets: sets)
}

func parseGameNumber(game: String) -> Int {
    let regex = Regex {
        "Game "
        Capture { OneOrMore(.digit) } transform: { substring -> Int in Int(String(substring))! }
    }

    return game.firstMatch(of: regex).map { $0.output.1 }!
}

func parseSets(sets: String) -> [CubeSet] {
    let setsArray = sets.components(separatedBy: ";")

    return setsArray.map {
        $0.components(separatedBy: ",").map(parseCube)
    }.map(CubeSet.init)
}

func parseCube(cube: String) -> Cube {
    let regex = Regex {
        Capture { OneOrMore(.digit) } transform: { substring -> Int in Int(String(substring))! }
        " "
        Capture {
            ChoiceOf {
                "red"
                "green"
                "blue"
            }
        } transform: { substring -> Color in Color(rawValue: String(substring))! }
    }

    return cube.firstMatch(of: regex).map { Cube(count: $0.output.1, color: $0.output.2) }!
}

struct Game {
    var id: Int
    var sets: [CubeSet]
}

struct CubeSet {
    var cubes: [Cube]
}

struct Cube {
    var count: Int
    var color: Color
}

enum Color: String {
    case red, blue, green
}
