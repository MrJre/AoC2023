import Foundation

func day15part1(input: [String]) -> Int {
    input.reduce(0) { $0 + hash(string: $1) }
}

func hash(string: String) -> Int {
    string.compactMap { $0.asciiValue }.map(Int.init).reduce(0) { (($0 + $1) * 17) % 256 }
}

func day15part2(input: [String]) -> Int {
    let lensOperations = input.map(LensOperation.init)
    let boxes: [Int: [Lens]] = fillBoxes(with: lensOperations)
    return boxes.reduce(0) { result, box in
        result + box.value.enumerated().map { (box.key + 1) * ($0 + 1) * $1.focalLength }.reduce(0, +)
    }
}

func fillBoxes(with lensOperations: [LensOperation]) -> [Int: [Lens]] {
    var boxes: [Int: [Lens]] = [:]
    for lensOperation in lensOperations {
        switch lensOperation {
        case .lens(let lens):
            let hash = hash(string: lens.name)
            var box: [Lens] = (boxes[hash] ?? [])
            if let index = box.firstIndex(where: { $0.name == lens.name }) {
                box[index] = lens
            } else {
                box.append(lens)
            }
            boxes[hash] = box
        case .remove(let name):
            let hash = hash(string: name)
            boxes[hash] = boxes[hash]?.filter { $0.name != name }
        }
    }
    return boxes
}

enum LensOperation {
    case remove(String)
    case lens(Lens)

    init(rawValue: String) {
        let lensComponents = rawValue.components(separatedBy: "=")
        if lensComponents.count > 1 {
            self = .lens(Lens(name: lensComponents[0], focalLength: Int(lensComponents[1])!))
        } else if rawValue.hasSuffix("-") {
            self = .remove(String(rawValue.dropLast()))
        } else {
            fatalError()
        }
    }
}

struct Lens {
    let name: String
    let focalLength: Int
}
