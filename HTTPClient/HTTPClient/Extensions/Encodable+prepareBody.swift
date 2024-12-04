import Foundation

public extension Encodable {
    func prepareBody() -> Data? {
        var encode: Data? {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .custom { date, encoder in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                let stringData = formatter.string(from: date)
                var container = encoder.singleValueContainer()
                try container.encode(stringData)
            }
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(self)
        }

        return encode
    }
}
