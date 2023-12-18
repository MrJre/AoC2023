import Foundation

func parseDay14Input(from file: String) -> RockGrid {
    let grid = file.components(separatedBy: "\n").filter { !$0.isEmpty }
    let elements = grid.flatMap { line in
        line.map { element in
            switch element {
            case "O": return RockType.round
            case "#": return RockType.cube
            case ".": return RockType.none
            default: fatalError()
            }
        }
    }
    let width = grid[0].count
    let height = grid.count
    return RockGrid(width: width, height: height, elements: elements)
}

struct RockGrid {
    let width: Int
    let height: Int
    let elements: [RockType]
}
extension RockGrid: CustomDebugStringConvertible {
    var debugDescription: String {
        var result: [String] = []
        for y in 0..<height {
            let elements = Array(elements[(y * width)..<((y * width) + width)])
            let descriptions = elements.map(\.debugDescription).joined()
            result.append(descriptions)
        }

        return result.joined(separator: "\n")
    }
}

enum RockType {
    case round
    case cube
    case none
}

extension RockType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .round: return "O"
        case .cube: return "#"
        case .none: return "."
        }
    }
}
