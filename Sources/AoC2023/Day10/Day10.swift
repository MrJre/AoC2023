import Foundation

func day10part1(input: PipeGrid) -> Int {
    let start = input.nodes.filter { $0.type == .start }.first!
    let neighbours = start.neighbours.compactMap {
        let node = input.node(x: $0.1.x, y: $0.1.y)
        switch $0.0 {
        case .north: return node.type.isConnectingSouth ? ($0.0, $0.1) : nil
        case .east: return node.type.isConnectingWest ? ($0.0, $0.1) : nil
        case .south: return node.type.isConnectingNorth ? ($0.0, $0.1) : nil
        case .west: return node.type.isConnectingEast ? ($0.0, $0.1) : nil
        }
    }
    
    let sanitizedStart = PipeNode(pipe: start.pipe, type: start.type, neighbours: neighbours)
    var sanitizedNodes = input.nodes
    sanitizedNodes[input.nodes.firstIndex { $0.pipe == start.pipe }!] = sanitizedStart
    let sanitizedGrid = PipeGrid(width: input.width, height: input.height, nodes: sanitizedNodes)

    // map draw
    for y in 0..<input.height {
        let line = input.nodes[(y * input.width)..<(y * input.width + input.width)].map { $0.type.debugDescription }
        print(line.reduce("", +))
    }

    print("")

    let path = calcPath(grid: sanitizedGrid, start: sanitizedStart)

    // path draw
    for y in 0..<input.height {
        var line = input.nodes[(y * input.width)..<(y * input.width + input.width)].map { $0.type.debugDescription }
        let openInLine = path.filter { $0.y == y }
        openInLine.forEach { line[$0.x] = "P" }
        print(line.reduce("", +))
    }

    return path.count / 2
}


func calcPath(grid: PipeGrid, start: PipeNode) -> Set<Pipe> {
    var path: Set<Pipe> = []
    var neighbours = start.neighbours.map { $0.1 }

    while true {
        neighbours = neighbours.filter { !path.contains($0) }
        if neighbours.count == 0 { break }
        path = path.union(neighbours)
        neighbours = neighbours.flatMap { grid.node(x: $0.x, y: $0.y).neighbours.map { $0.1 } }
    }

    return path
}


func day10part2(input: PipeGrid) -> Int {
    let start = input.nodes.filter { $0.type == .start }.first!
    let neighbours = start.neighbours.compactMap {
        let node = input.node(x: $0.1.x, y: $0.1.y)
        switch $0.0 {
        case .north: return node.type.isConnectingSouth ? ($0.0, $0.1) : nil
        case .east: return node.type.isConnectingWest ? ($0.0, $0.1) : nil
        case .south: return node.type.isConnectingNorth ? ($0.0, $0.1) : nil
        case .west: return node.type.isConnectingEast ? ($0.0, $0.1) : nil
        }
    }

    let sanitizedStart = PipeNode(pipe: start.pipe, type: start.type, neighbours: neighbours)
    var sanitizedNodes = input.nodes
    sanitizedNodes[input.nodes.firstIndex { $0.pipe == start.pipe }!] = sanitizedStart
    let sanitizedGrid = PipeGrid(width: input.width, height: input.height, nodes: sanitizedNodes)

    let pipePath = calcPath(grid: sanitizedGrid, start: sanitizedStart)
    let nodePath = pipePath.map { input.node(x: $0.x, y: $0.y) }

    // path draw
    for y in 0..<input.height {
        var line = input.nodes[(y * input.width)..<(y * input.width + input.width)].map { $0.type.debugDescription }
        let openInLine = nodePath.filter { $0.pipe.y == y }
        openInLine.forEach { line[$0.pipe.x] = "P" }
        print(line.reduce("", +))
    }

    print("")

    let openPlaces = input.nodes
        .filter { !pipePath.contains($0.pipe) }
        .filter { isInside(node: $0, path: nodePath) }

    // draw
    for y in 0..<input.height {
        var line = input.nodes[(y * input.width)..<(y * input.width + input.width)].map { $0.type.debugDescription }
        let openInLine = openPlaces.filter { $0.pipe.y == y }
        openInLine.forEach { line[$0.pipe.x] = "O" }
        print(line.reduce("", +))
    }

    return openPlaces.count
}

func isInside(node: PipeNode, path: [PipeNode]) -> Bool {

    //print("- \(node.pipe) - \(node.type) -")
    let row = path.filter { node.pipe.y == $0.pipe.y }.sorted { $0.pipe.x < $1.pipe.x }
    let verts = row.filter { $0.type != .horizontal }
    let relevant = verts.filter { $0.pipe.x < node.pipe.x }

    var collapsed: [PipeNode] = relevant.filter { $0.type == .vertical }

    for rel in zip(relevant, relevant.dropFirst()) {
        switch (rel.0.type, rel.1.type) {
        case
            (.neBend, .swBend),
            (.nwBend, .seBend),
            (.swBend, .neBend),
            (.seBend, .nwBend):
            collapsed.append(PipeNode(pipe: rel.0.pipe, type: .vertical, neighbours: []))
        default: break
        }
    }

    return collapsed.count % 2 == 1
}
