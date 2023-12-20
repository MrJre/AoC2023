import Foundation

func parseDay16Input(from file: String) -> Grid<GridNode<MirrorType>> {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }.map { $0.map { String($0) }}
    let width = result[0].count
    let height = result.count
    return Grid(width: width, height: height, elements: result.enumerated().flatMap { y, row in
        row.enumerated().map { x, rawElement in
            let element: MirrorType
            switch rawElement {
            case "-": element = .horizontalSplitter
            case "|": element = .verticalSplitter
            case "/": element = .rightLeaningMirror
            case "\\": element = .leftLeaningMirror
            case ".": element = .empty
            default: fatalError()
            }
            var neighbours: [GridDirection: GridCoordinate] = [:]
            if 0..<height ~= y-1 { neighbours[.north] = GridCoordinate(x: x, y: y-1) }
            if 0..<height ~= y+1 { neighbours[.south] = GridCoordinate(x: x, y: y+1) }
            if 0..<width ~= x-1 { neighbours[.west] = GridCoordinate(x: x-1, y: y) }
            if 0..<width ~= x+1 { neighbours[.east] = GridCoordinate(x: x+1, y: y) }

            return GridNode(coordinate: GridCoordinate(x: x, y: y), element: element, neighbours: neighbours)
        }
    })
}

class Grid<Element> {
    let width: Int
    let height: Int
    let elements: [Element]

    init(width: Int, height: Int, elements: [Element]) {
        self.width = width
        self.height = height
        self.elements = elements
    }

    func element(at coordinate: GridCoordinate) -> Element {
        return elements[coordinate.y * width + coordinate.x]
    }
}

extension Grid: CustomDebugStringConvertible where Element: CustomNodeStringConvertible {
    var debugDescription: String {
        var result: [String] = []
        for y in 0..<height {
            let elements = Array(elements[(y * width)..<((y * width) + width)])
            let descriptions = elements.map(\.nodeDescription).joined()
            result.append(descriptions)
        }

        return result.joined(separator: "\n")
    }
}

extension Grid where Element == GridNode<MirrorType> {
    var visitedDebugDescription: String {
        var result: [String] = []
        for y in 0..<height {
            let elements = Array(elements[(y * width)..<((y * width) + width)])
            let descriptions = elements.map { $0.visited.reduce(false) { $0 || $1.value } ? ($0.element == .empty ? "#" : $0.element.debugDescription) : $0.element.debugDescription }.joined()
            result.append(descriptions)
        }

        return result.joined(separator: "\n")
    }
}

class GridNode<Element> {
    let coordinate: GridCoordinate
    let element: Element
    let neighbours: [GridDirection: GridCoordinate]
    var visited: [GridDirection: Bool] = [.north: false, .east: false, .south: false, .west: false]

    init(coordinate: GridCoordinate, element: Element, neighbours: [GridDirection : GridCoordinate]) {
        self.coordinate = coordinate
        self.element = element
        self.neighbours = neighbours
    }
}

extension GridNode: CustomDebugStringConvertible where Element: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(coordinate): \(element.debugDescription) - n: \(neighbours) - v: \(visited)"
    }
}

protocol CustomNodeStringConvertible {
    var nodeDescription: String { get }
}

extension GridNode: CustomNodeStringConvertible where Element: CustomDebugStringConvertible {
    var nodeDescription: String { element.debugDescription }
}

struct GridCoordinate {
    let x: Int
    let y: Int
}

extension GridCoordinate: CustomDebugStringConvertible {
    var debugDescription: String { "(\(x),\(y))"}
}

enum GridDirection {
    case north, west, south, east
}

extension GridDirection: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .north: "N"
        case .west: "W"
        case .south: "S"
        case .east: "E"
        }
    }
}

enum MirrorType {
    case horizontalSplitter
    case verticalSplitter
    case leftLeaningMirror
    case rightLeaningMirror
    case empty
}

extension MirrorType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .horizontalSplitter:
            return "-"
        case .verticalSplitter:
            return "|"
        case .leftLeaningMirror:
            return "\\"
        case .rightLeaningMirror:
            return "/"
        case .empty:
            return "."
        }
    }
}
