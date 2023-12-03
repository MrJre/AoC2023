import Foundation
import XCTest
@testable import AoC2023

final class Day3Tests: XCTestCase {
    func testInput() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
        
        let feed = parseDay3Input(from: input)
        let result = day3part1(input: feed)

        XCTAssertEqual(result, 4361)
    }

    func test() {
        let input = "793*722"

        let feed = parseDay3Input(from: input)
        let result = day3part1(input: feed)

        XCTAssertEqual(result, 1515)
    }

    func testInputPart2() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """

        let feed = parseDay3Input(from: input)
        let result = day3part2(input: feed)

        XCTAssertEqual(result, 467835)
    }
}
