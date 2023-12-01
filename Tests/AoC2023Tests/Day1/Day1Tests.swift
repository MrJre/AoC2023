import Foundation
import XCTest
@testable import AoC2023

final class Day1Tests: XCTestCase {

    func testTransformDigits() {
        XCTAssertEqual("219", insertDigitsForSpelledNumbers(input: "two1nine"))
        XCTAssertEqual("8wo3", insertDigitsForSpelledNumbers(input: "eightwothree"))
        XCTAssertEqual("abc123xyz", insertDigitsForSpelledNumbers(input: "abcone2threexyz"))
        XCTAssertEqual("x2ne34", insertDigitsForSpelledNumbers(input: "xtwone3four"))
        XCTAssertEqual("49eight72", insertDigitsForSpelledNumbers(input: "4nineeightseven2"))
        XCTAssertEqual("z1ight234", insertDigitsForSpelledNumbers(input: "zoneight234"))
        XCTAssertEqual("7pqrst6teen", insertDigitsForSpelledNumbers(input: "7pqrstsixteen"))
    }

    func testInputP1() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """
        XCTAssertEqual(day1part1(input: parseDay1Input(from: input)), 142)
    }

    func testInputP2() {
        let input = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

        XCTAssertEqual(day1part2(input: parseDay1Input(from: input)), 281)
    }

    func testCase() {
        let input = """
        twonetwone
        """
        XCTAssertEqual(day1part2(input: parseDay1Input(from: input)), 21)
    }

    func testSingleNumber() {
        let input = """
        two
        """
        XCTAssertEqual(day1part2(input: parseDay1Input(from: input)), 22)
    }

    func testConcat() {
        let input = """
        twone
        """
        XCTAssertEqual(day1part2(input: parseDay1Input(from: input)), 21)
    }
}
