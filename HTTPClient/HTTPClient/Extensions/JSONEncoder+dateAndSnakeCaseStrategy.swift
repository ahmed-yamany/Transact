import Foundation

public extension JSONEncoder {
    static func dateAndSnakeCaseStrategy() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .dateFormateWithSingleValueCounter
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

public extension JSONEncoder.DateEncodingStrategy {
    static var dateFormateWithSingleValueCounter: JSONEncoder.DateEncodingStrategy {
        .custom { date, encoder in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let stringData = formatter.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(stringData)
        }
    }
}
