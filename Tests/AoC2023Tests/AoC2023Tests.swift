import XCTest
@testable import AoC2023

final class AoC2023Tests: XCTestCase {
    func testDay1Part1() throws {
        let file = file(forDay: 1)
        let input = parseDay1Input(from: file)
        
        let result = day1part1(input: input)
        XCTAssertEqual(result, 54450)
    }
    
    func testDay1Part2() throws {
        let file = file(forDay: 1)
        let input = parseDay1Input(from: file)
        
        let result = day1part2(input: input)
        XCTAssertEqual(result, 54265)
    }
    
    func testDay2Part1() throws {
        let file = file(forDay: 2)
        let input = parseDay2Input(from: file)
        
        let result = day2part1(input: input)
        XCTAssertEqual(result, 2545)
    }
    
    func testDay2Part2() throws {
        let file = file(forDay: 2)
        let input = parseDay2Input(from: file)
        
        let result = day2part2(input: input)
        XCTAssertEqual(result, 78111)
    }
    
    func testDay3Part1() throws {
        let file = file(forDay: 3)
        let input = parseDay3Input(from: file)
        
        let result = day3part1(input: input)
        XCTAssertEqual(result, 533784)
    }
    
    func testDay3Part2() throws {
        let file = file(forDay: 3)
        let input = parseDay3Input(from: file)
        
        let result = day3part2(input: input)
        XCTAssertEqual(result, 78826761)
    }
}
