import Foundation
import XCTest
@testable import AoC2023

final class Day10Tests: XCTestCase {
    func testSimpleInput() {
        let input = """
        .....
        .S-7.
        .|.|.
        .L-J.
        .....
        """
        let result = day10part1(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 4)
    }

    func testComplexInput() {
        let input = """
        ..F7.
        .FJ|.
        SJ.L7
        |F--J
        LJ...
        """

        let result = day10part1(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 8)
    }

    func testSimpleInputP2() {
        let input = """
        .....
        .S-7.
        .|.|.
        .L-J.
        .....
        """
        let result = day10part2(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 1)
    }

    func testComplexInputP2() {
        let input = """
        ...........
        .S-------7.
        .|F-----7|.
        .||.....||.
        .||.....||.
        .|L-7.F-J|.
        .|..|.|..|.
        .L--J.L--J.
        ...........
        """
        let result = day10part2(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 4)
    }

    func testGaplessInputP2() {
        let input = """
        ..........
        .S------7.
        .|F----7|.
        .||....||.
        .||....||.
        .|L-7F-J|.
        .|..||..|.
        .L--JL--J.
        ..........
        """
        let result = day10part2(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 4)
    }

    func testLargeInputP2() {
        let input = """
        .F----7F7F7F7F-7....
        .|F--7||||||||FJ....
        .||.FJ||||||||L7....
        FJL7L7LJLJ||LJ.L-7..
        L--J.L7...LJS7F-7L7.
        ....F-J..F7FJ|L7L7L7
        ....L7.F7||L7|.L7L7|
        .....|FJLJ|FJ|F7|.LJ
        ....FJL-7.||.||||...
        ....L---J.LJ.LJLJ...
        """

        let result = day10part2(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 8)
    }

    func testMoreInputP2() {
        let input = """
        FF7FSF7F7F7F7F7F---7
        L|LJ||||||||||||F--J
        FL-7LJLJ||||||LJL-77
        F--JF--7||LJLJ7F7FJ-
        L---JF-JLJ.||-FJLJJ7
        |F|F-JF---7F7-L7L|7|
        |FFJF7L7F-JF7|JL---7
        7-L-JL7||F7|L7F-7F7|
        L.L7LFJ|||||FJL7||LJ
        L7JLJL-JLJLJL--JLJ.L
        """

        let result = day10part2(input: parseDay10Input(from: input))
        XCTAssertEqual(result, 10)
    }
}
