import Foundation

func parseDay7InputPart1(from file: String, strengths: [CardType: Int]) -> [(Hand, Int)] {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }

    let handsAndBets = result.map {
        let row = $0.components(separatedBy: .whitespaces)
        let hand = row[0].map(String.init).map(CardType.init)
        let bet = Int(row[1])!

        let cardHand = hand.map { Card(type: $0, strength: strengths[$0]!) }

        return (Hand(cards: cardHand), bet)
    }

    return handsAndBets
}

func parseDay7InputPart2(from file: String, strengths: [CardType: Int]) -> [(Hand, Int)] {
    let result = file.components(separatedBy: "\n").filter { !$0.isEmpty }

    let handsAndBets = result.map {
        let row = $0.components(separatedBy: .whitespaces)
        let hand = row[0].map(String.init).map(CardType.init)
        let bet = Int(row[1])!

        let cardHand = hand.map { Card(type: $0, strength: strengths[$0]!) }

        return (Hand(cards: cardHand, replace: true), bet)
    }

    return handsAndBets
}


struct Hand {
    let cards: [Card]
    let handStrength: HandStrength

    init(cards: [Card], replace: Bool = false) {
        self.cards = cards
        handStrength = HandStrength(cards: cards.sorted(by: <), replace: replace)
    }
}

extension Hand: CustomDebugStringConvertible {
    var debugDescription: String { "\(cards.reduce("") { $0.appending($1.debugDescription) }), \(handStrength)" }
}

extension Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.handStrength == rhs.handStrength {
            for i in 0..<lhs.cards.count {
                if lhs.cards[i] == rhs.cards[i] { continue }
                return lhs.cards[i] < rhs.cards[i]
            }
        }
        return lhs.handStrength < rhs.handStrength
    }
}

struct Card {
    var type: CardType
    var strength: Int
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.strength < rhs.strength
    }
}

extension Card: Hashable {}

extension Card: CustomDebugStringConvertible {
    var debugDescription: String { type.debugDescription }
}

enum CardType {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    init(string: String) {
        switch string {
        case "2": self = .two
        case "3": self = .three
        case "4": self = .four
        case "5": self = .five
        case "6": self = .six
        case "7": self = .seven
        case "8": self = .eight
        case "9": self = .nine
        case "T": self = .ten
        case "J": self = .jack
        case "Q": self = .queen
        case "K": self = .king
        case "A": self = .ace
        default: fatalError()
        }
    }
}

extension CardType: Hashable {}

extension CardType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .two: "2"
        case .three: "3"
        case .four: "4"
        case .five: "5"
        case .six: "6"
        case .seven: "7"
        case .eight: "8"
        case .nine: "9"
        case .ten: "T"
        case .jack: "J"
        case .queen: "Q"
        case .king: "K"
        case .ace: "A"
        }
    }
}

enum HandStrength: Int {
    case highCard
    case pair
    case twoPair
    case threeOfAKind
    case fullHouse
    case fourOfAKind
    case fiveOfAKind

    init(cards: [Card], replace: Bool = false) {
        var cardTypeCounts: [CardType: Int] = [:]
        var cardCounts: [Card: Int] = [:]
        cards.forEach {
            cardTypeCounts[$0.type] = (cardTypeCounts[$0.type] ?? 0) + 1
            cardCounts[$0] = (cardCounts[$0] ?? 0) + 1
        }

        if replace {
            if let jacks = cardTypeCounts[CardType.jack] {
                let sortedKeys: [CardType] = cardTypeCounts.keys.sorted { cardTypeCounts[$0]! > cardTypeCounts[$1]! }.filter { $0 != .jack }
                
                if sortedKeys.count > 0, let first = sortedKeys.first {
                    let dominantTypes = cardTypeCounts.filter { $0.value == cardTypeCounts[first] }

                    let dominants = cardCounts.filter { cardPair in
                        dominantTypes.contains { type in cardPair.key.type == type.key }
                    }.keys.sorted(by: { $0.strength > $1.strength })

                    if let first = dominants.first {
                        cardTypeCounts[first.type] = (cardTypeCounts[first.type] ?? 0) + jacks
                        cardTypeCounts[.jack] = nil
                    }
                }
            }
        }

        let strength = [
            HandStrength.fiveOfAKind(from: cardTypeCounts),
            HandStrength.fourOfAKind(from: cardTypeCounts),
            HandStrength.fullHouse(from: cardTypeCounts),
            HandStrength.threeOfAKind(from: cardTypeCounts),
            HandStrength.twoPair(from: cardTypeCounts),
            HandStrength.pair(from: cardTypeCounts),
            HandStrength.highCard(from: cardTypeCounts)
        ].compactMap { $0 }.first!

        self = strength
    }

    private static func fiveOfAKind(from cardCounts: [CardType: Int]) -> HandStrength? {
        cardCounts.filter { $0.value == 5 }.count > 0 ? .fiveOfAKind : nil
    }

    private static func fourOfAKind(from cardCounts: [CardType: Int]) -> HandStrength? {
        cardCounts.filter { $0.value == 4 }.count > 0 ? .fourOfAKind : nil
    }

    private static func fullHouse(from cardCounts: [CardType: Int]) -> HandStrength? {
        let threeOfAKind = cardCounts.filter { $0.value == 3 }
        let twoOfAKind = cardCounts.filter { $0.value == 2 }
        return threeOfAKind.count > 0 && twoOfAKind.count > 0 ? .fullHouse : nil
    }

    private static func threeOfAKind(from cardCounts: [CardType: Int]) -> HandStrength? {
        cardCounts.filter { $0.value == 3 }.count > 0 ? .threeOfAKind : nil
    }

    private static func twoPair(from cardCounts: [CardType: Int]) -> HandStrength? {
        cardCounts.filter { $0.value == 2 }.count == 2 ? .twoPair : nil
    }

    private static func pair(from cardCounts: [CardType: Int]) -> HandStrength? {
        cardCounts.filter { $0.value == 2 }.count == 1 ? .pair : nil
    }

    private static func highCard(from cardCounts: [CardType: Int]) -> HandStrength? {
        .highCard
    }
}

extension HandStrength: Comparable {
    static func < (lhs: HandStrength, rhs: HandStrength) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension HandStrength: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .fiveOfAKind: return "5x"
        case .fourOfAKind: return "4x"
        case .fullHouse: return "fh"
        case .threeOfAKind: return "3x"
        case .twoPair: return "xx"
        case .pair: return "2x"
        case .highCard: return "hc"
        }
    }
}
