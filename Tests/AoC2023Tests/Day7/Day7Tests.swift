import Foundation
import XCTest
@testable import AoC2023

final class Day7Tests: XCTestCase {
    func testInputPart1() {
        let strengths: [CardType: Int] = [.two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .jack: 11, .queen: 12, .king: 13, .ace: 14]

        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

        let hands = parseDay7InputPart1(from: input, strengths: strengths)
        let result = day7part1(input: hands)

        XCTAssertEqual(result, 6440)
    }

    func testCompare() {
        let strengths: [CardType: Int] = [.two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .jack: 11, .queen: 12, .king: 13, .ace: 14]

        let input = """
        KK677 28
        KTJJT 220
        """
        
        let hands = parseDay7InputPart1(from: input, strengths: strengths)
        let result = day7part1(input: hands)

        XCTAssertEqual(result, 276)
    }

    func testInputPart2() {
        let strengths: [CardType: Int] = [.two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .jack: 1, .queen: 12, .king: 13, .ace: 14]

        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

        let hands = parseDay7InputPart2(from: input, strengths: strengths)
        let result = day7part2(input: hands)

        XCTAssertEqual(result, 5905)
    }
}
