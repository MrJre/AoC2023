import Foundation
import XCTest
@testable import AoC2023

final class Day15Tests: XCTestCase {
    func testInput() {
        let input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
        let result = day15part1(input: parseDay15Input(from: input))

        XCTAssertEqual(result, 1320)
    }

    func testInputPart2() {
        let input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
        let result = day15part2(input: parseDay15Input(from: input))

        XCTAssertEqual(result, 145)
    }
}
