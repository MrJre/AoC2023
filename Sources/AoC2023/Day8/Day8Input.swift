import Foundation
import RegexBuilder

struct Day8Input {
    func parseDay8Input(from file: String) -> ([Direction], [String: Node]) {
        var result = file.components(separatedBy: "\n").filter { !$0.isEmpty }

        let directions = result.removeFirst().map { Direction(rawValue: String($0)) }
        
        var map = [String: Node]()
        let nodes = result.map(parseNode)
        nodes.forEach {
            map[$0.name] = $0
        }
        
        return (directions, map)
    }

    func parseNode(nodeString: String) -> Node {
        let regex = Regex {
            OneOrMore {
                Capture {
                    OneOrMore(.word)
                }
            }
        }

        let nodes = nodeString.matches(of: regex).map { $0.output.1 }
        return Node(name: String(nodes[0]), left: String(nodes[1]), right: String(nodes[2]))
    }
}

enum Direction: String {
    case left, right

    init(rawValue: String) {
        switch rawValue {
        case "L": self = .left
        case "R": self = .right
        default: fatalError()
        }
    }
}

struct Node {
    let name: String
    let left: String
    let right: String
}
