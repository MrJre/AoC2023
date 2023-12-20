import Foundation
import XCTest
@testable import AoC2023

final class Day16Tests: XCTestCase {
    func testInput() {
        let input = """
        .|...\\....
        |.-.\\.....
        .....|-...
        ........|.
        ..........
        .........\\
        ..../.\\\\..
        .-.-/..|..
        .|....-|.\\
        ..//.|....
        """

        let result = day16part1(input: parseDay16Input(from: input))

        XCTAssertEqual(result, 46)
    }
}
