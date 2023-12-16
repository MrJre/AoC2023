import Foundation

func day5part1(input: (seeds: [Int], maps: [Map])) -> Int {

    let locations = input.seeds.map { findLocation(for: $0, maps: input.maps) }

    let seedRanges = input.seeds.map { $0...$0 }
    let locationRanges = seedRanges.flatMap { findLocationRange(for: $0, maps: input.maps) }
    return locationRanges.map { $0.lowerBound }.min()!
}

func day5part2(input: (seeds: [Int], maps: [Map])) -> Int {

    var seedRanges: [ClosedRange<Int>] = []
    for i in 0..<input.seeds.count/2 {
        let lower = input.seeds[i * 2]
        let upper = input.seeds[i * 2 + 1] + lower
        seedRanges.append(lower...upper-1)
    }

    var location = 0
    var seed = 0

    while seedRanges.filter({ $0.contains(seed) }).isEmpty {
        seed = findSeed(for: location, maps: input.maps)
        location += 1
    }

    return location - 1
}

func findLocation(for seed: Int, maps: [Map]) -> Int {
    var source = seed
    maps.forEach {
        source = $0.map(source: source)
    }
    return source
}

func findSeed(for location: Int, maps: [Map]) -> Int {
    var source = location
    maps.reversed().forEach {
        source = $0.invMap(source: source)
    }
    return source
}

func findLocationRange(for seedRange: ClosedRange<Int>, maps: [Map]) -> [ClosedRange<Int>] {
    var source = [seedRange]
    for (i, map) in maps.enumerated() {
        print(i)
        var newRanges: [ClosedRange<Int>] = []
        for range in source {
            newRanges.append(contentsOf: map.map(source: range))
        }
        source = newRanges
    }

    return source
}
