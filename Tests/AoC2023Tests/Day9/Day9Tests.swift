import Foundation
import XCTest
@testable import AoC2023

final class Day9Tests: XCTestCase {
    func testInput() {
        let input = """
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
        """
        let parsed = parseDay9Input(from: input)
        let result = day9part1(input: parsed)

        XCTAssertEqual(result, 114)
    }

    func testInputP2() {
        let input = """
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
        """
        let parsed = parseDay9Input(from: input)
        let result = day9part2(input: parsed)

        XCTAssertEqual(result, 2)
    }

}
