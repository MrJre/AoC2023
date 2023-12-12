import Foundation

func parseDay10Input(from file: String) -> PipeGrid {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }
    let crudeMap = result.flatMap { $0.map(String.init) }

    let height = result.count
    let width = result[0].count

    var map: [PipeNode] = []

    for y in 0..<height {
        for x in 0..<width {
            let pipe = Pipe(x: x, y: y)
            let pipeType = PipeType(type: crudeMap[y * width + x])
            let neighbours = findNeighbours(for: pipe, type: pipeType, width: width, height: height)
            map.append(PipeNode(pipe: pipe, type: pipeType, neighbours: neighbours))
        }
    }
    return PipeGrid(width: width, height: height, nodes: map)
}

func findNeighbours(for pipe: Pipe, type: PipeType, width: Int, height: Int) -> [(WDirection, Pipe)] {
    let x = pipe.x
    let y = pipe.y

    let west: Pipe? = (0..<width).contains(x-1) ? Pipe(x: x - 1, y: y) : nil
    let east: Pipe? = (0..<width).contains(x+1) ? Pipe(x: x + 1, y: y) : nil
    let north: Pipe? = (0..<height).contains(y-1) ? Pipe(x: x, y: y - 1) : nil
    let south: Pipe? = (0..<height).contains(y+1) ? Pipe(x: x, y: y + 1) : nil

    var neighbours: [(WDirection, Pipe?)] = []

    switch type {
    case .vertical:  neighbours = [(.north, north), (.south, south)]
    case .horizontal: neighbours = [(.east, east), (.west, west)]
    case .neBend: neighbours = [(.north, north), (.east, east)]
    case .nwBend: neighbours = [(.north, north), (.west, west)]
    case .swBend: neighbours = [(.south, south), (.west, west)]
    case .seBend: neighbours = [(.south, south), (.east, east)]
    case .start: neighbours = [(.north, north), (.east, east), (.south, south), (.west, west)]
    case .none: neighbours = []
    }

    var result: [(WDirection, Pipe)] = []

    for neighbour in neighbours {
        if neighbour.1 != nil { result.append((neighbour.0, neighbour.1!)) }
    }

    return result
}

struct PipeGrid {
    var width: Int
    var height: Int

    var nodes: [PipeNode]

    func node(x: Int, y: Int) -> PipeNode {
        nodes[y * width + x]
    }
}

struct PipeNode {
    let pipe: Pipe
    let type: PipeType

    let neighbours: [(WDirection, Pipe)]
}

struct Pipe {
    let x: Int
    let y: Int
}

extension Pipe: Equatable {}
extension Pipe: Hashable {}

extension Pipe: CustomDebugStringConvertible {
    var debugDescription: String { "(\(x),\(y))"}
}

enum WDirection {
    case north
    case south
    case east
    case west
}

extension WDirection: Comparable {
    static func < (lhs: WDirection, rhs: WDirection) -> Bool {
        let order: [WDirection] = [.south, .east, .north, .west]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
}
extension WDirection: Hashable {}

enum PipeType {
    case vertical
    case horizontal
    case neBend
    case nwBend
    case swBend
    case seBend
    case start
    case none

    init(type: String) {
        switch type {
        case "-": self = .horizontal
        case "|": self = .vertical
        case "L": self = .neBend
        case "J": self = .nwBend
        case "7": self = .swBend
        case "F": self = .seBend
        case "S": self = .start
        default: self = .none
        }
    }

    var isConnectingEast: Bool { self == .horizontal || self == .neBend || self == .seBend || self == .start }
    var isConnectingWest: Bool { self == .horizontal || self == .nwBend || self == .swBend || self == .start }
    var isConnectingNorth: Bool { self == .vertical || self == .nwBend || self == .neBend || self == .start }
    var isConnectingSouth: Bool { self == .vertical || self == .swBend || self == .seBend || self == .start }
}

extension PipeType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .vertical: return "|"
        case .horizontal: return "-"
        case .neBend: return "L"
        case .nwBend: return "J"
        case .swBend: return "7"
        case .seBend: return "F"
        case .start: return "S"
        case .none: return "."
        }
    }
}
