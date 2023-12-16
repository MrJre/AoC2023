import Foundation
import XCTest
@testable import AoC2023

final class Day13Tests: XCTestCase {
    func testInput() {
        let input = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

        let result = day13part1(input: parseDay13Input(from: input))
        XCTAssertEqual(result, 405)
    }

    func testFirst() {
        let input = """
        ##..####..##..#
        #.##.#..##..##.
        ##..###.##..##.
        .#..#.#........
        ######.########
        ##..##...####..
        ##..###.#....#.
        .###..#.######.
        #.##.#..##..##.
        #....#..##..##.
        #....##.##..##.
        ######.##.##.##
        .####..###..###
        """

        let result = day13part1(input: parseDay13Input(from: input))
        XCTAssertEqual(result, 11)
    }

    func testInputP2() {
        let input = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

        let result = day13part2(input: parseDay13Input(from: input))
        XCTAssertEqual(result, 400)
    }
}
