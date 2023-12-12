import Foundation

func parseDay12Input(from file: String) -> [SpringRow] {
    let result = file
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.components(separatedBy: .whitespaces) }
        .map { SpringRow(configuration: $0[0].map(String.init), arrangement: $0[1].components(separatedBy: ",").compactMap(Int.init)) }

    return result
}

struct SpringRow {
    let configuration: [String]
    let arrangement: [Int]
}

extension SpringRow: Hashable {}
