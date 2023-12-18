import Foundation
import XCTest
@testable import AoC2023

final class Day14Tests: XCTestCase {
    func testInputP1() {
        let input = """
        O....#....
        O.OO#....#
        .....##...
        OO.#O....O
        .O.....O#.
        O.#..O.#.#
        ..O..#O..O
        .......O..
        #....###..
        #OO..#....
        """

        let result = day14part1(input: parseDay14Input(from: input))
        XCTAssertEqual(result, 136)
    }

    func testInputP2() {
        let input = """
        O....#....
        O.OO#....#
        .....##...
        OO.#O....O
        .O.....O#.
        O.#..O.#.#
        ..O..#O..O
        .......O..
        #....###..
        #OO..#....
        """

        let result = day14part2(input: parseDay14Input(from: input))
        XCTAssertEqual(result, 64)
    }
}
