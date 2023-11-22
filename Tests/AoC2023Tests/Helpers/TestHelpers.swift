import Foundation
@testable import AoC2023

func file(forDay day: Int) -> String {
    let url = Bundle.module.url(forResource: "Day\(day)", withExtension: ".txt")
    return try! String(contentsOf: url!)
}