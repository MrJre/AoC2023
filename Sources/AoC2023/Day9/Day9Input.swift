import Foundation

func parseDay9Input(from file: String) -> [[Int]] {
    let result = file
        .components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }
    return result
}
