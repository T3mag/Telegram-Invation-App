import Foundation

extension Formatter {
    static let withSpaceSeparator: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.usesGroupingSeparator = true
        fmt.groupingSeparator = " "
        fmt.groupingSize = 3
        return fmt
    }()
}

extension BinaryInteger {
    var formattedWithSpaces: String {
        return Formatter.withSpaceSeparator.string(for: self) ?? "\(self)"
    }
}

extension BinaryFloatingPoint {
    var formattedWithSpaces: String {
        // для Double/Float сначала преобразуем в NSNumber
        let number = NSNumber(value: Double(self))
        return Formatter.withSpaceSeparator.string(from: number) ?? "\(self)"
    }
}
