import Foundation

func parseDay5Input(from file: String) -> (seeds: [Int], maps: [Map]) {
    let result = file.components(separatedBy: "\n")

    let seeds = result[0].components(separatedBy: " ").dropFirst().compactMap(Int.init)

    var maps: [Map] = []
    var currentLookups: [Lookup] = []

    result.dropFirst(2).forEach {
        if $0.contains("map") {
            return
        }
        if $0.isEmpty {
            maps.append(Map(lookups: currentLookups))
            currentLookups = []
            return
        }
        let lookup = $0.components(separatedBy: " ")
        currentLookups.append(Lookup(from: Int(lookup[1])!, to: Int(lookup[0])!, step: Int(lookup[2])!))
    }

    maps.append(Map(lookups: currentLookups))

    return (seeds, maps)
}

struct Map {
    let lookups: [Lookup]

    func map(source: Int) -> Int {
        let transforms = lookups.map { $0.transform(source: source) }.filter { $0 != source }
        if transforms.isEmpty { return source }

        return transforms.first!
    }

    func invMap(source: Int) -> Int {
        let transforms = lookups.map { $0.invTransform(source: source) }.filter { $0 != source }
        if transforms.isEmpty { return source }

        return transforms.first!
    }

    func map(source: ClosedRange<Int>) -> [ClosedRange<Int>] {
        var transforms = lookups.flatMap {
            let result = $0.transform(source: source)
            return result
        }

        transforms = transforms.filter {
            $0 != source
        }

        if transforms.isEmpty { return [source] }

        if transforms.count > 0 { print("-> ", transforms) }
        return transforms
    }
}

struct Lookup {
    let from: ClosedRange<Int>
    let to: ClosedRange<Int>
    let step: Int

    init(from: Int, to: Int, step: Int) {
        self.from = from...from+step-1
        self.to = to...to+step-1
        self.step = step
    }

    func transform(source: Int) -> Int {
        if from.contains(source) {
            return source - from.lowerBound + to.lowerBound
        }
        return source
    }

    func invTransform(source: Int) -> Int {
        if to.contains(source) {
            return source - to.lowerBound + from.lowerBound
        }
        return source
    }

    func transform(source: ClosedRange<Int>) -> [ClosedRange<Int>] {
        if !source.overlaps(from) { return [source] }
        
        var ranges: [ClosedRange<Int>] = []

        let overlap = source.clamped(to: from)

        if source.lowerBound < overlap.lowerBound {
            ranges.append(source.lowerBound...overlap.lowerBound-1)
        }
        
        ranges.append(map(source: overlap.lowerBound)...map(source: overlap.upperBound))

        if source.upperBound > overlap.upperBound {
            ranges.append(overlap.upperBound+1...source.upperBound)
        }

        return ranges
    }

    private func map(source: Int) -> Int {
        return source - from.lowerBound + to.lowerBound
    }
}

extension Lookup: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(from) -> \(to)"
    }
}
