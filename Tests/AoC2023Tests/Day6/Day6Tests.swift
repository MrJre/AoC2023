import Foundation
import XCTest
@testable import AoC2023

final class Day6Tests: XCTestCase {
    func testExample() {
        let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

        let races = parseDay6InputPart1(from: input)
        let result = day6part1(input: races)

        XCTAssertEqual(result, 288)
    }

}
