import Foundation

func day16part1(input: Grid<GridNode<MirrorType>>) -> Int {
    guard let first = input.elements.first else { fatalError() }
    return countEnergizedTiles(grid: input, from: first, direction: .east)
}

func day16part2(input: Grid<GridNode<MirrorType>>) -> Int {
    var energizedCounts: [Int] = []
    for x in 0..<input.width {
        let topNode = input.element(at: GridCoordinate(x: x, y: 0))
        energizedCounts.append(countEnergizedTiles(grid: input, from: topNode, direction: .south))
        let bottomNode = input.element(at: GridCoordinate(x: x, y: input.height - 1))
        energizedCounts.append(countEnergizedTiles(grid: input, from: bottomNode, direction: .north))
    }
    for y in 0..<input.height {
        let westNode = input.element(at: GridCoordinate(x: 0, y: y))
        energizedCounts.append(countEnergizedTiles(grid: input, from: westNode, direction: .east))
        let eastNode = input.element(at: GridCoordinate(x: input.width - 1, y: y))
        energizedCounts.append(countEnergizedTiles(grid: input, from: eastNode, direction: .west))
    }

    return energizedCounts.max()!
}

func countEnergizedTiles(grid: Grid<GridNode<MirrorType>>, from node: GridNode<MirrorType>, direction: GridDirection) -> Int {
    var nextNodes: [(node: GridNode<MirrorType>, direction: GridDirection)] = [(node, direction)]

    while(!nextNodes.isEmpty) {
        var newNodes: [(node: GridNode<MirrorType>, direction: GridDirection)] = []

        func appendNextNode(next: (node: GridNode<MirrorType>, direction: GridDirection), direction: GridDirection) {
            guard let nextCoordinate = next.node.neighbours[direction] else { return }
            let nextNode = grid.element(at: nextCoordinate)
            if let visited = nextNode.visited[direction], visited {
                return
            }
            newNodes.append((node: nextNode, direction: direction))
        }

        for next in nextNodes {
            switch (next.node.element, next.direction) {
            case (.horizontalSplitter, .east), (.horizontalSplitter, .west),
                (.verticalSplitter, .north), (.verticalSplitter, .south), (.empty, _):
                appendNextNode(next: next, direction: next.direction)

            case (.horizontalSplitter, .north), (.horizontalSplitter, .south):
                appendNextNode(next: next, direction: .east)
                appendNextNode(next: next, direction: .west)
            case (.verticalSplitter, .east), (.verticalSplitter, .west):
                appendNextNode(next: next, direction: .north)
                appendNextNode(next: next, direction: .south)

            case (.leftLeaningMirror, .east):
                appendNextNode(next: next, direction: .south)
            case (.leftLeaningMirror, .south):
                appendNextNode(next: next, direction: .east)
            case (.leftLeaningMirror, .west):
                appendNextNode(next: next, direction: .north)
            case (.leftLeaningMirror, .north):
                appendNextNode(next: next, direction: .west)

            case (.rightLeaningMirror, .east):
                appendNextNode(next: next, direction: .north)
            case (.rightLeaningMirror, .north):
                appendNextNode(next: next, direction: .east)
            case (.rightLeaningMirror, .west):
                appendNextNode(next: next, direction: .south)
            case (.rightLeaningMirror, .south):
                appendNextNode(next: next, direction: .west)
            }
            next.node.visited[next.direction] = true
        }
        nextNodes = newNodes
    }
    let count = grid.elements.filter { $0.visited.reduce(false) { $0 || $1.value } }.count
    resetGrid(grid: grid)
    return count
}

func resetGrid(grid: Grid<GridNode<MirrorType>>) {
    grid.elements.forEach { element in
        element.visited.forEach { element.visited[$0.key] = false }
    }
}
