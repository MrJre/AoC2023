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
    
    func testDay4Part1() throws {
        let file = file(forDay: 4)
        let input = parseDay4Input(from: file)
        
        let result = day4part1(input: input)
        XCTAssertEqual(result, 21213)
    }
    
    func testDay4Part2() throws {
        let file = file(forDay: 4)
        let input = parseDay4Input(from: file)
        
        let result = day4part2(input: input)
        XCTAssertEqual(result, 8549735)
    }
    
    func testDay5Part1() throws {
        let file = file(forDay: 5)
        let input = parseDay5Input(from: file)

        let result = day5part1(input: input)
        XCTAssertEqual(result, 309796150)
    }
    
    func testDay5Part2() throws {
        let file = file(forDay: 5)
        let input = parseDay5Input(from: file)
        
        let result = day5part2(input: input)
        XCTAssertEqual(result, -1)
    }
    
    func testDay6Part1() throws {
        let file = file(forDay: 6)
        let input = parseDay6InputPart1(from: file)
        
        let result = day6part1(input: input)
        XCTAssertEqual(result, 608902)
    }
    
    func testDay6Part2() throws {
        let file = file(forDay: 6)
        let input = parseDay6InputPart2(from: file)
        
        let result = day6part2(input: input)
        XCTAssertEqual(result, 46173809)
    }
    
    func testDay7Part1() throws {
        let strengths: [CardType: Int] = [.two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .jack: 11, .queen: 12, .king: 13, .ace: 14]

        let file = file(forDay: 7)
        let input = parseDay7InputPart1(from: file, strengths: strengths)

        let result = day7part1(input: input)
        XCTAssertEqual(result, 251287184)
    }
    
    func testDay7Part2() throws {
        let strengths: [CardType: Int] = [.jack: 1, .two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .queen: 12, .king: 13, .ace: 14]


        let file = file(forDay: 7)
        let input = parseDay7InputPart2(from: file, strengths: strengths)
        
        let result = day7part2(input: input)
        XCTAssertEqual(result, -1)
    }
    
    func testDay8Part1() throws {
        let file = file(forDay: 8)
        let input = Day8Input().parseDay8Input(from: file)

        let result = day8part1(input: input)
        XCTAssertEqual(result, 19783)
    }
    
    func testDay8Part2() throws {
        let file = file(forDay: 8)
        let input = Day8Input().parseDay8Input(from: file)
        
        let result = day8part2(input: input)
        XCTAssertEqual(result, 9177460370549)
    }
    
    func testDay9Part1() throws {
        let file = file(forDay: 9)
        let input = parseDay9Input(from: file)
        
        let result = day9part1(input: input)
        XCTAssertEqual(result, -1)
    }
    
    func testDay9Part2() throws {
        let file = file(forDay: 9)
        let input = parseDay9Input(from: file)
        
        let result = day9part2(input: input)
        XCTAssertEqual(result, -1)
    }
    
    func testDay10Part1() throws {
        let file = file(forDay: 10)
        let input = parseDay10Input(from: file)
        
        let result = day10part1(input: input)
        XCTAssertEqual(result, 6838)
    }
    
    func testDay10Part2() throws {
        let file = file(forDay: 10)
        let input = parseDay10Input(from: file)
        
        let result = day10part2(input: input)
        XCTAssertEqual(result, -1)
    }
    
    func testDay11Part1() throws {
        let file = file(forDay: 11)
        let input = parseDay11Input(from: file)
        
        let result = day11part1(input: input)
        XCTAssertEqual(result, 9_565_386)
    }
    
    func testDay11Part2() throws {
        let file = file(forDay: 11)
        let input = parseDay11Input(from: file)
        
        let result = day11part2(input: input)
        XCTAssertEqual(result, 857_986_849_428)
    }
    
    func testDay12Part1() throws {
        let file = file(forDay: 12)
        let input = parseDay12Input(from: file)
        
        let result = day12part1(input: input)
        XCTAssertEqual(result, 7361)
    }
    
    func testDay12Part2() throws {
        let file = file(forDay: 12)
        let input = parseDay12Input(from: file)
        
        let result = day12part2(input: input)
        XCTAssertEqual(result, 83317216247365)
    }
    
    func testDay13Part1() throws {
        let file = file(forDay: 13)
        let input = parseDay13Input(from: file)
        
        let result = day13part1(input: input)
        XCTAssertEqual(result, 33780)
    }
    
    func testDay13Part2() throws {
        let file = file(forDay: 13)
        let input = parseDay13Input(from: file)
        
        let result = day13part2(input: input)
        XCTAssertEqual(result, 23479)
    }
    
    func testDay14Part1() throws {
        let file = file(forDay: 14)
        let input = parseDay14Input(from: file)
        
        let result = day14part1(input: input)
        XCTAssertEqual(result, 113078)
    }
    
    func testDay14Part2() throws {
        let file = file(forDay: 14)
        let input = parseDay14Input(from: file)
        
        let result = day14part2(input: input)
        XCTAssertEqual(result, 94255)
    }
}
