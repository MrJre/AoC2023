import Foundation

func parseDay15Input(from file: String) -> [String] {
    file.components(separatedBy: ",")
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
}
