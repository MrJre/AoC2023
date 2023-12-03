import Foundation

func parseDay3Input(from file: String) -> ([PartNumber], [Symbol]) {
    let result = file.components(separatedBy: "\n")

    var partNumbers: [PartNumber] = []
    var symbols: [Symbol] = []

    for (y, line) in result.enumerated() {

        var part = ""

        for (x, char) in line.unicodeScalars.enumerated() {
            if CharacterSet.decimalDigits.contains(char) {
                part.append(String(char))
            } else {
                if CharacterSet.decimalDigits.union(CharacterSet.alphanumerics).union(CharacterSet(charactersIn: ".")).inverted.contains(char) {
                    symbols.append(Symbol(y: y, x: x, symbol: String(char)))
                }
                if !part.isEmpty {
                    partNumbers.append(PartNumber(y: y, range: x-part.count...x-1, number: Int(part)!))
                    part = ""
                }
            }
        }
        
        if !part.isEmpty {
            let x = line.count-1
            partNumbers.append(PartNumber(y: y, range: x-part.count+1...x, number: Int(part)!))
        }

    }



    return (partNumbers, symbols)
}

struct PartNumber {
    let y: Int
    let range: ClosedRange<Int>
    let number: Int
}

struct Symbol {
    let y: Int
    let x: Int
    let symbol: String
}
