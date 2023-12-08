import Foundation
import XCTest
@testable import AoC2023

final class Day8Tests: XCTestCase {
    func testInputPart1A() {
        let input = """
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
        """

        let result = day8part1(input: Day8Input().parseDay8Input(from: input))
        XCTAssertEqual(result, 2)
    }

    func testInputPart1B() {
        let input = """
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
        """

        let result = day8part1(input: Day8Input().parseDay8Input(from: input))
        XCTAssertEqual(result, 6)
    }

    func testInputPart2() {
        let input = """
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
        """

        let result = day8part2(input: Day8Input().parseDay8Input(from: input))
        XCTAssertEqual(result, 6)
    }

    func testGCD() {
        let a = 48
        let b = 18
        let gcd = findGreatestCommonDenominator(a: a, b: b)

        XCTAssertEqual(gcd, 6)
    }

    func testLCM() {
        let a = 15
        let b = 27
        let lcm = findLeastCommonMultiplier(a: a, b: b)

        XCTAssertEqual(lcm, 135)
    }
}
