import Foundation

func parseDay13Input(from file: String) -> [MirrorGrid] {
    let result = file.components(separatedBy: "\n\n")
    return result.map { gridString in
        let grid = gridString.components(separatedBy: "\n").filter { !$0.isEmpty }
        let elements = grid.flatMap { line in
            line.map { element in
                switch element {
                case ".": return GroundType.ash
                case "#": return GroundType.rock
                default: fatalError()
                }
            }
        }
        let width = grid[0].count
        let height = grid.count
        return MirrorGrid(width: width, height: height, elements: elements)
    }
}

struct MirrorGrid {
    let width: Int
    let height: Int
    let elements: [GroundType]
}

extension MirrorGrid: CustomDebugStringConvertible {
    var debugDescription: String {
        var result: [String] = []
        for y in 0..<height {
            let elements: [GroundType] = Array(elements[(y * width)..<((y * width) + width)])
            let descriptions = elements.map(\.debugDescription).joined()
            result.append(descriptions)
        }

        return result.joined(separator: "\n")
    }
}

enum GroundType {
    case ash
    case rock
}

extension GroundType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .ash: return "."
        case .rock: return "#"
        }
    }
}
