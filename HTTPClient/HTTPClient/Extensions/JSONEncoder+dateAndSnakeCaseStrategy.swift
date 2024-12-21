import Foundation

extension JSONEncoder {
    static func dateAndSnakeCaseStrategy() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = Self.dateEncodingStrategy()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    private static func dateEncodingStrategy() -> JSONEncoder.DateEncodingStrategy {
        .custom { date, encoder in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let stringData = formatter.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(stringData)
        }
    }
}
