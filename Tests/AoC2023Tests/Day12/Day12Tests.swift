import Foundation
import XCTest
@testable import AoC2023

final class Day12Tests: XCTestCase {
    func testInput() {
        let input = """
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
        """

        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 21)
    }

    func testRowOne() {
        let input = "???.### 1,1,3"
        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 1)
    }

    func testRowTwo() {
        let input = ".??..??...?##. 1,1,3"
        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 4)
    }

    func testRowThree() {
        let input = "?#?#?#?#?#?#?#? 1,3,1,6"
        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 1)
    }

    func testRowFour() {
        let input = "????.#...#... 4,1,1"
        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 1)
    }

    func testRowSix() {
        let input = "?###???????? 3,2,1"
        let result = day12part1(input: parseDay12Input(from: input))
        XCTAssertEqual(result, 10)
    }

    func testUnfoldRow() {
        let input = ".# 1"
        let parsedInput = parseDay12Input(from: input)

        let result = [(configuration: [".", "#", "?", ".", "#", "?", ".", "#", "?", ".", "#", "?", ".", "#"], numbers: [1,1,1,1,1])]

        XCTAssertEqual(unfold(input: parsedInput).first?.configuration, result.first?.configuration)
    }
}
