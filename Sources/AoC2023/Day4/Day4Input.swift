import Foundation

func parseDay4Input(from file: String) -> [([Int], [Int])] {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }

    return result.map {
        let cardsLine = $0.components(separatedBy: ":")[1]
        let twoCards = cardsLine.components(separatedBy: "|")
        let winning = twoCards[0].components(separatedBy: " ").compactMap(Int.init)
        let owned = twoCards[1].components(separatedBy: " ").compactMap(Int.init)
        return (winning, owned)
    }
}
