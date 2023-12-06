import Foundation
import XCTest
@testable import AoC2023

final class Day5Tests: XCTestCase {

    func testParsing() {
        let result = parseDay5Input(from: input)
        XCTAssertEqual(result.seeds, [79, 14, 55, 13])
        XCTAssertEqual(result.maps.count, 7)
    }

    func testExamplePart1() {
        let input = parseDay5Input(from: input)
        let result = day5part1(input: input)

        XCTAssertEqual(result, 35)
    }

    func testExamplePart2() {
        let input = parseDay5Input(from: input)
        let result = day5part2(input: input)

        XCTAssertEqual(result, 46)
    }

    func testLookup() {
        let result = Lookup(from: 7, to: 1, step: 6)
        XCTAssertEqual(result.from, 7...12)
        XCTAssertEqual(result.to, 1...6)
    }

    func testLookup2() {
        let result = Lookup(from: 7, to: 32, step: 6)
        XCTAssertEqual(result.from, 7...12)
        XCTAssertEqual(result.to, 32...37)
    }

    func testLookup3() {
        let result = Lookup(from: 98, to: 50, step: 2)
        XCTAssertEqual(result.from, 98...99)
        XCTAssertEqual(result.to, 50...51)
    }

    func testOverlappingRangeIsLargerUpper() {
        let seeds = 8...15 // 8, 9, 10, 11, 12, 13, 14, 15
        let lookup = Lookup(from: 7, to: 1, step: 6) // 7, 8, 9 ,10, 11, 12
        // 7...12 -> 1...6
        let result = lookup.transform(source: seeds)
        XCTAssertEqual(result, [2...6, 13...15])
    }

    func testOverlappingRangeIsSubRangeOfFrom() {
        let seeds = 12...14
        let lookup = Lookup(from: 7, to: 0, step: 8)
        let result = lookup.transform(source: seeds)

        XCTAssertEqual(result, [5...7])
    }

    func testOverlappingRangeIsEqualToFrom() {
        let seeds = 7...14
        let lookup = Lookup(from: 7, to: 0, step: 8)
        let result = lookup.transform(source: seeds)

        XCTAssertEqual(result, [0...7])
    }

    func testOverlappingRangeIsSmallerThanLower() {
        let seeds = 5...12
        let lookup = Lookup(from: 7, to: 1, step: 6)
        let result = lookup.transform(source: seeds)

        XCTAssertEqual(result, [5...6, 1...6])
    }

    func testOverlappingBoth() {
        let seeds = 5...12
        let lookup = Lookup(from: 6, to: 0, step: 6)
        let result = lookup.transform(source: seeds)

        XCTAssertEqual(result, [5...5, 0...5, 12...12])
    }

    func testNoOverlap() {
        let seeds = 15...20
        let lookup = Lookup(from: 7, to: 0, step: 8)
        let result = lookup.transform(source: seeds)

        XCTAssertEqual(result, [15...20])
    }

    func testSingleValueTransform() {
        let seeds = 79...92
        let lookup = Lookup(from: 50, to: 52, step: 48)

        XCTAssertEqual(lookup.transform(source: seeds), [81...94])
    }

    func testMap() {
        let lookup1 = Lookup(from: 98, to: 50, step: 2)
        let lookup2 = Lookup(from: 50, to: 52, step: 48)

        let map = Map(lookups: [lookup1, lookup2])

        XCTAssertEqual(map.map(source: 79...79), [81...81])
    }

    var input: String = ""

    override func setUp() {
        input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """
    }
}
